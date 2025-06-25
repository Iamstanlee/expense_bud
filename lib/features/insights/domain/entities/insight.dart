import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/utils/pair.dart';

class InsightEntity {
  final List<TransactionEntity> cur;
  final List<TransactionEntity> prev;

  const InsightEntity(this.cur, this.prev);

  bool get isEmpty => cur.isEmpty;

  /// Filter transactions based on type
  List<TransactionEntity> _filterByType(
      List<TransactionEntity> transactions, TransactionType type) {
    return transactions.where((t) => t.transactionType == type).toList();
  }

  /// Get current expenses
  List<TransactionEntity> get expenses =>
      _filterByType(cur, TransactionType.expense);

  /// Get current income
  List<TransactionEntity> get income =>
      _filterByType(cur, TransactionType.income);

  /// Get previous expenses
  List<TransactionEntity> get prevExpenses =>
      _filterByType(prev, TransactionType.expense);

  /// Get previous income
  List<TransactionEntity> get prevIncome =>
      _filterByType(prev, TransactionType.income);

  /// total amount of expenses for this particular insight period
  int get totalExpenses => expenses.fold(0, (a, c) => a += c.amount);

  /// total amount of income for this particular insight period
  int get totalIncome => income.fold(0, (a, c) => a += c.amount);

  /// total net balance (income - expenses)
  int get netBalance => totalIncome - totalExpenses;

  /// total amount of expense for the previous insight of this particular insight period
  /// used to estimate percentage inc or dec.
  int get previousTotalExpenses =>
      prevExpenses.fold(0, (a, c) => a += c.amount);

  /// total amount of income for the previous insight period
  int get previousTotalIncome => prevIncome.fold(0, (a, c) => a += c.amount);

  /// previous net balance
  int get previousNetBalance => previousTotalIncome - previousTotalExpenses;

  /// interpolate percentage change into the range of 0 - 100 for expenses
  double get expensesPercentageChange => (totalExpenses - previousTotalExpenses)
      .normalize(
          0,
          increasedExpensesFromLastPeriod
              ? totalExpenses
              : previousTotalExpenses)
      .floorToDouble()
      .abs();

  /// interpolate percentage change into the range of 0 - 100 for income
  double get incomePercentageChange => (totalIncome - previousTotalIncome)
      .normalize(
          0, increasedIncomeFromLastPeriod ? totalIncome : previousTotalIncome)
      .floorToDouble()
      .abs();

  /// interpolate percentage change for net balance
  double get netBalancePercentageChange => (netBalance - previousNetBalance)
      .normalize(
          0,
          improvedNetBalanceFromLastPeriod
              ? netBalance.abs()
              : previousNetBalance.abs())
      .floorToDouble()
      .abs();

  bool get increasedExpensesFromLastPeriod =>
      totalExpenses > previousTotalExpenses;
  bool get increasedIncomeFromLastPeriod => totalIncome > previousTotalIncome;
  bool get improvedNetBalanceFromLastPeriod => netBalance > previousNetBalance;

  List<double> splinePoints() {
    final list = cur.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final listOfAmount = list.map((e) =>
        e.transactionType == TransactionType.expense ? -e.amount : e.amount);
    List<double> points = [];
    int max = listOfAmount.isEmpty
        ? 0
        : listOfAmount.fold(0, (max, e) => e > max ? e : max);
    int min = listOfAmount.isEmpty
        ? 0
        : listOfAmount.fold(0, (min, e) => e < min ? e : min);
    for (final amount in listOfAmount) {
      double point = amount.normalize(min, max, upperBound: 1);
      points.add(point);
    }
    return points;
  }

  Map<ExpenseCategoryItem, Pair<int, int>>
      sortedMapOfCategoryToPairOfAmountAndNumOfEntries(
          {TransactionType? type}) {
    final map = mapOfCategoryToPairOfAmountAndNumOfEntries(type: type);
    final mapEntry = <ExpenseCategoryItem, Pair<int, int>>{};
    // sort map by total amount
    map.keys.toList()
      ..sort((a, b) => map[b]!.left.compareTo(map[a]!.left))
      ..forEach((key) {
        mapEntry.putIfAbsent(key, () => map[key]!);
      });
    return mapEntry;
  }

  /// mapping of entries total amount and count to category
  /// [left] of Pair holds totalAmount
  /// [right] of Pair holds numOfEntries
  Map<ExpenseCategoryItem, Pair<int, int>>
      mapOfCategoryToPairOfAmountAndNumOfEntries({TransactionType? type}) {
    final filteredCur = type != null ? _filterByType(cur, type) : cur;

    return filteredCur.fold({}, (map, transaction) {
      final item = categoryItems()
          .singleWhere((c) => c.category == transaction.category);
      final amount = transaction.amount;
      if (map.containsKey(item)) {
        map.update(item, (value) => Pair(value.left + amount, value.right + 1));
      } else {
        map.putIfAbsent(item, () => Pair(amount, 1));
      }
      return map;
    });
  }
}
