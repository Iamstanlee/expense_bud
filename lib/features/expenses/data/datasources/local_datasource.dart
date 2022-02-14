import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/features/expenses/data/models/expense.dart';
import 'package:hive/hive.dart';

abstract class IExpenseLocalDataSource {
  Future<List<ExpenseModel>> getCurrentDayEntries();
  Future<Map<String, List<ExpenseModel>>> getCurrentMonthEntries();
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
      final _monthKey = _getMonthKey(expense.createdAt);
      final _dayKey = _getDayKey(expense.createdAt);
      if (_has(_monthKey)) {
        final _month = _box.get(_monthKey)! as Map;
        if (_month.containsKey(_dayKey)) {
          final _items = _month[_dayKey];
          final _updatedItems = [expense, ..._items];
          await _box.put(_monthKey, {..._month, _dayKey: _updatedItems});
        } else {
          await _box.put(_monthKey, {
            ..._month,
            _dayKey: [expense]
          });
        }
      } else {
        await _box.put(_monthKey, {
          _dayKey: [expense]
        });
      }
      return expense;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Map<String, List<ExpenseModel>>> getCurrentMonthEntries() async {
    try {
      final today = DateTime.now().toIso8601String();
      final _key = _getMonthKey(today);
      final _currentMonth = _box.get(_key, defaultValue: {}) as Map;
      Map<String, List<ExpenseModel>> mapEntry = {};
      _currentMonth.keys.toList().cast<String>()
        ..sort((a, b) => b.compareTo(a))
        ..forEach((key) {
          mapEntry[key] = (_currentMonth[key] as List).cast<ExpenseModel>();
        });
      return mapEntry;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ExpenseModel>> getCurrentDayEntries() async {
    try {
      final today = DateTime.now().toIso8601String();
      final _monthKey = _getMonthKey(today);
      final _dayKey = _getDayKey(today);
      final _currentMonth = _box.get(_monthKey, defaultValue: {}) as Map;
      List<ExpenseModel> entries = [];
      if (_currentMonth.isEmpty) return entries;
      if (_currentMonth.containsKey(_dayKey)) {
        entries = (_currentMonth[_dayKey] as List).cast<ExpenseModel>();
      }
      return entries;
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
