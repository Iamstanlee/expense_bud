import 'package:expense_tracker/core/failure/exceptions.dart';
import 'package:expense_tracker/core/utils/date_formatter.dart';
import 'package:expense_tracker/features/expenses/data/models/expense.dart';
import 'package:hive/hive.dart';

abstract class IExpenseLocalDataSource {
  Future<List<ExpenseModel>> getCurrentDayExpenseEntries();
  Future<Map<String, List<ExpenseModel>>> getAllExpenseEntries();
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense);
}

class ExpenseLocalDataSource implements IExpenseLocalDataSource {
  final Box _box;
  final DateFormatter _dateFormatter = DateFormatter(kStorageDateFormat);
  ExpenseLocalDataSource(this._box);

  @override
  Future<ExpenseModel> createExpenseEntry(ExpenseModel expense) async {
    try {
      final _key = _getKey(expense.createdAt);
      if (_has(_key)) {
        final _itemsInBox = _box.get(_key)!;
        final _updatedItemsInBox = [expense, ..._itemsInBox];
        await _box.put(_key, _updatedItemsInBox);
      } else {
        await _box.put(_key, [expense]);
      }
      return expense;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Map<String, List<ExpenseModel>>> getAllExpenseEntries() async {
    try {
      // final mapEntry = _box.toMap().map((key, value) =>
      //     MapEntry(key as String, (value as List).cast<ExpenseModel>()));
      Map<String, List<ExpenseModel>> mapEntry = {};
      _box.keys.toList().cast<String>()
        ..sort((a, b) => b.compareTo(a))
        ..forEach((key) {
          mapEntry[key] = (_box.get(key) as List).cast<ExpenseModel>();
        });
      return mapEntry;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ExpenseModel>> getCurrentDayExpenseEntries() async {
    try {
      final today = DateTime.now().toIso8601String();
      final key = _getKey(today);
      final entries = _box.get(key, defaultValue: [])!.cast<ExpenseModel>();
      return entries;
    } catch (e) {
      throw CacheException();
    }
  }

  String _getKey(String date) {
    return _dateFormatter.stringToKey(date);
  }

  bool _has(String key) {
    return _box.containsKey(key);
  }
}
