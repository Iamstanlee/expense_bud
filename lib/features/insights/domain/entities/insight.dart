import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/utils/pair.dart';

class InsightEntity {
  final List<ExpenseEntity> cur;
  final List<ExpenseEntity> prev;

  const InsightEntity(this.cur, this.prev);

  bool get isEmpty => cur.isEmpty && prev.isEmpty;

  /// total amount of expense for this particular insight period
  int get total => cur.fold(0, (a, c) => a += c.amount);

  /// total amount of expense for the previous insight of this particular insight period
  /// used to estimate percentage inc or dec.
  int get previousTotal => prev.fold(0, (a, c) => a += c.amount);

  /// interpolate percentage change into the range of 0 - 100
  double get percentageIncreaseOrDec => (total - previousTotal)
      .normalize(0, increasedFromLastInsightPeriod ? total : previousTotal)
      .floorToDouble()
      .abs();

  bool get increasedFromLastInsightPeriod => total > previousTotal;

  List<double> splinePoints() {
    final list = cur.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final lisfOfAmount = list.map((e) => e.amount);
    List<double> points = [];
    int max = lisfOfAmount.isEmpty ? 0 : lisfOfAmount.getMax();
    int min = lisfOfAmount.isEmpty ? 0 : lisfOfAmount.getMin();
    for (final amount in lisfOfAmount) {
      double point = amount.normalize(min, max, upperBound: 1);
      points.add(point);
    }
    return points;
  }

  Map<ExpenseCategoryItem, Pair<int, int>>
      sortedMapOfCategoryToPairOfAmountAndNumOfEntries() {
    final map = mapOfCategoryToPairOfAmountAndNumOfEntries();
    final mapEntry = <ExpenseCategoryItem, Pair<int, int>>{};
    // sort map by total amount
    map.values.toList()
      ..sort((a, b) => b.left.compareTo(a.left))
      ..forEach((value) {
        final k = map.keys.singleWhere((key) => map[key] == value);
        mapEntry[k] = value;
      });
    return mapEntry;
  }

  /// mapping of entries total amount and count to category
  /// [left] of Pair holds totalAmount
  /// [right] of Pair holds numOfEntries
  Map<ExpenseCategoryItem, Pair<int, int>>
      mapOfCategoryToPairOfAmountAndNumOfEntries() {
    return cur.fold({}, (map, expense) {
      final item =
          categoryItems().singleWhere((c) => c.category == expense.category);
      final amount = expense.amount;
      if (map.containsKey(item)) {
        map.update(item, (value) => Pair(value.left + amount, value.right + 1));
      } else {
        map.putIfAbsent(item, () => Pair(amount, 1));
      }
      return map;
    });
  }
}
