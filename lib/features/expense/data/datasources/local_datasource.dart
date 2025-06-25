import 'package:expense_bud/core/data/datasources/local_datasource.dart';
import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:hive/hive.dart';

abstract class IExpenseLocalDataSource {
  Stream<Map<String, List<TransactionModel>>> watchMonthlyEntries();
  Future<TransactionModel> createExpenseEntry(TransactionModel transaction);
  Future<void> eraseEntries();
}

/// Storage Data structure Model
///```dart
/// {
/// "2022-02": {
/// "2022-02-01" : [TransactionModel],
/// "2022-02-02" : [TransactionModel, TransactionModel],
/// "2022-02-03" : [TransactionModel],
///},
/// "2022-03": {
/// "2022-02-01" : [TransactionModel, TransactionModel],
/// "2022-02-02" : [TransactionModel],
/// "2022-02-03" : [TransactionModel, TransactionModel],
///},
/// }
/// ```
class ExpenseLocalDataSource extends LocalDataSource
    implements IExpenseLocalDataSource {
  final Box _box;
  ExpenseLocalDataSource(this._box) : super(_box);

  @override
  Future<TransactionModel> createExpenseEntry(
      TransactionModel transaction) async {
    try {
      final monthKey = getMonthKey(transaction.createdAt);
      final dayKey = getDayKey(transaction.createdAt);
      if (has(monthKey)) {
        final month = _box.get(monthKey)! as Map;
        if (month.containsKey(dayKey)) {
          final items = month[dayKey];
          final updatedItems = [transaction, ...items];
          await _box.put(monthKey, {...month, dayKey: updatedItems});
        } else {
          await _box.put(monthKey, {
            ...month,
            dayKey: [transaction]
          });
        }
      } else {
        await _box.put(monthKey, {
          dayKey: [transaction]
        });
      }
      return transaction;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Stream<Map<String, List<TransactionModel>>> watchMonthlyEntries() {
    return _box.watch().map((event) {
      final Map<String, List<TransactionModel>> result = {};
      final keys = _box.keys;
      for (final key in keys) {
        final String monthKey = key.toString();
        final Map month = _box.get(monthKey)!;
        for (final dayKey in month.keys) {
          final String day = dayKey.toString();
          final List items = month[day];
          result[day] = List<TransactionModel>.from(items);
        }
      }
      return result;
    });
  }

  @override
  Future<void> eraseEntries() async {
    await _box.clear();
  }
}
