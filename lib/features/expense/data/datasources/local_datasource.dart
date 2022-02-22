import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/features/expense/data/models/expense.dart';
import 'package:hive/hive.dart';

abstract class IExpenseLocalDataSource {
  Stream<Map<String, List<ExpenseModel>>> watchMonthlyEntries();
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense);
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
class ExpenseLocalDataSource implements IExpenseLocalDataSource {
  final Box _box;
  final DateFormatter _dayFormatter = DateFormatter(kDay);
  final DateFormatter _monthFormatter = DateFormatter(kMonth);
  ExpenseLocalDataSource(this._box);

  @override
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense) async {
    try {
      final monthKey = _getMonthKey(expense.createdAt);
      final dayKey = _getDayKey(expense.createdAt);
      if (_has(monthKey)) {
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
  Future<void> eraseEntries() async {
    try {
      await _box.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  Map<String, List<ExpenseModel>> _getMonthlyEntries() {
    final today = DateTime.now().toIso8601String();
    final key = _getMonthKey(today);
    final currentMonth = _box.get(key, defaultValue: {}) as Map;
    Map<String, List<ExpenseModel>> mapEntry = {};
    currentMonth.keys.toList().cast<String>()
      ..sort((a, b) => b.compareTo(a))
      ..forEach((k) {
        mapEntry[k] = (currentMonth[k] as List).cast<ExpenseModel>();
      });
    return mapEntry;
  }

  String _getDayKey(String date) {
    return _dayFormatter.stringToKey(date);
  }

  String _getMonthKey(String date) {
    return _monthFormatter.stringToKey(date);
  }

  bool _has(String key) {
    return _box.containsKey(key);
  }
}
