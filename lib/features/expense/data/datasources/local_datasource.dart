import 'package:expense_bud/core/data/datasources/local_datasource.dart';
import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:hive/hive.dart';

abstract class IExpenseLocalDataSource {
  Stream<Map<String, List<ExpenseModel>>> watchMonthlyEntries();
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense);
  Future<void> deleteExpenseEntry(String id);
  Future<void> eraseEntries();
}

/// Storage Data structure Model
///```dart
/// {
/// "2022-02": {
/// "2022-02-01" : [ExpenseModel],
/// "2022-02-02" : [ExpenseModel, ExpenseModel],
/// "2022-02-03" : [ExpenseModel],
///},
/// "2022-03": {
/// "2022-02-01" : [ExpenseModel, ExpenseModel],
/// "2022-02-02" : [ExpenseModel],
/// "2022-02-03" : [ExpenseModel, ExpenseModel],
///},
/// }
/// ```
class ExpenseLocalDataSource extends LocalDataSource
    implements IExpenseLocalDataSource {
  final Box _box;
  ExpenseLocalDataSource(this._box) : super(_box) {
    _migrateExistingData();
  }

  void _migrateExistingData() {
    try {
      // Simple migration: if there's any data structure issue, clear the box
      // This ensures compatibility with the new ID field requirement
      final keys = _box.keys.toList();
      if (keys.isNotEmpty) {
        // Try to read first item to check if it has ID field
        final firstKey = keys.first;
        final data = _box.get(firstKey);
        if (data is Map && data.isNotEmpty) {
          final firstDayKey = data.keys.first;
          final items = data[firstDayKey] as List?;
          if (items != null && items.isNotEmpty) {
            final firstItem = items.first;
            if (firstItem is ExpenseModel) {
              try {
                // Try to access id field
                final _ = firstItem.id;
              } catch (e) {
                // Old data format, clear the box
                _box.clear();
              }
            }
          }
        }
      }
    } catch (e) {
      // If any error occurs during migration, clear the box to start fresh
      _box.clear();
    }
  }

  @override
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense) async {
    try {
      final monthKey = getMonthKey(expense.createdAt);
      final dayKey = getDayKey(expense.createdAt);
      if (has(monthKey)) {
        final month = _box.get(monthKey)! as Map;
        if (month.containsKey(dayKey)) {
          final items = month[dayKey];
          final updatedItems = [expense, ...items];
          await _box.put(monthKey, {...month, dayKey: updatedItems});
        } else {
          await _box.put(monthKey, {
            ...month,
            dayKey: [expense]
          });
        }
      } else {
        await _box.put(monthKey, {
          dayKey: [expense]
        });
      }
      return expense;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Stream<Map<String, List<ExpenseModel>>> watchMonthlyEntries() async* {
    yield _getMonthlyEntries();
    yield* _box
        .watch()
        .map((_) => _getMonthlyEntries())
        .handleError((e, s) => throw CacheException());
  }

  @override
  Future<void> deleteExpenseEntry(String id) async {
    try {
      final today = DateTime.now().toIso8601String();
      final monthKey = getMonthKey(today);
      
      if (has(monthKey)) {
        final month = _box.get(monthKey)! as Map;
        bool found = false;
        
        for (String dayKey in month.keys) {
          final items = month[dayKey] as List;
          final updatedItems = items.where((item) => (item as ExpenseModel).id != id).toList();
          
          if (items.length != updatedItems.length) {
            found = true;
            if (updatedItems.isEmpty) {
              month.remove(dayKey);
            } else {
              month[dayKey] = updatedItems;
            }
            break;
          }
        }
        
        if (found) {
          if (month.isEmpty) {
            await _box.delete(monthKey);
          } else {
            await _box.put(monthKey, month);
          }
        }
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> eraseEntries() async {
    try {
      await _box.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  Map<String, List<ExpenseModel>> _getMonthlyEntries() {
    final today = DateTime.now().toIso8601String();
    final key = getMonthKey(today);
    final currentMonth = _box.get(key, defaultValue: {}) as Map;
    Map<String, List<ExpenseModel>> mapEntry = {};
    currentMonth.keys.toList().cast<String>()
      ..sort((a, b) => b.compareTo(a))
      ..forEach((k) {
        mapEntry[k] = (currentMonth[k] as List).cast<ExpenseModel>();
      });
    return mapEntry;
  }
}
