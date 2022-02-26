import 'package:expense_bud/core/data/datasources/local_datasource.dart';
import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:expense_bud/features/insights/data/models/insight.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:hive/hive.dart';

abstract class IInsightLocalDataSource {
  Future<InsightModel> getInsightsForPeriod(InsightPeriod period);
}

class InsightLocalDataSource extends LocalDataSource
    implements IInsightLocalDataSource {
  final Box _box;
  InsightLocalDataSource(this._box) : super(_box);

  @override
  Future<InsightModel> getInsightsForPeriod(InsightPeriod period) async {
    try {
      return period.map(
        last3Days: () => _getLastNDaysInsights(3),
        last7Days: () => _getLastNDaysInsights(7),
        last14Days: () => _getLastNDaysInsights(14),
        thisMonth: () => _getMonthInsight(DateTime.now()),
        lastMonth: () {
          final thisMonth = DateTime.now();
          final lastMonth = DateTime(
            thisMonth.year,
            thisMonth.month == 1 ? 12 : thisMonth.month - 1,
          );
          return _getMonthInsight(lastMonth);
        },
      );
    } catch (e) {
      throw CacheException();
    }
  }

  /// query the insight from the last [n] days starting from current date
  InsightModel _getLastNDaysInsights(int lastNumOfDays, {DateTime? startDate}) {
    final initial = startDate ?? DateTime.now();
    List<String> lastNDaysKeys = [];
    List<String> prevLastNDaysKeys = [];
    for (var i = 0; i < lastNumOfDays; i++) {
      lastNDaysKeys.add(initial.subtract(Duration(days: i)).toIso8601String());
    }
    for (var i = 0; i < lastNumOfDays; i++) {
      prevLastNDaysKeys.add(
        initial.subtract(Duration(days: lastNumOfDays + i)).toIso8601String(),
      );
    }
    List<ExpenseModel> lastNDays = _pickEntries(lastNDaysKeys);
    List<ExpenseModel> prevLastN3Days = _pickEntries(prevLastNDaysKeys);
    return InsightModel(lastNDays, prevLastN3Days);
  }

  List<ExpenseModel> _pickEntries(List<String> keys) {
    List<ExpenseModel> entries = [];
    for (var key in keys) {
      final monthKey = getMonthKey(key);
      final dayKey = getDayKey(key);
      if (has(monthKey)) {
        final month = _box.get(monthKey)! as Map;
        if (month.containsKey(dayKey)) {
          entries.addAll(((_box.get(monthKey) as Map)[dayKey] as List)
              .cast<ExpenseModel>());
        }
      }
    }
    return entries;
  }

  InsightModel _getMonthInsight(DateTime initial) {
    final currentkey = getMonthKey(initial.toIso8601String());
    final previouskey = getMonthKey(DateTime(
      initial.month == 1 ? initial.year - 1 : initial.year,
      initial.month == 1 ? 12 : initial.month - 1,
    ).toIso8601String());
    final cur = _box.get(currentkey, defaultValue: {}) as Map;
    final prev = _box.get(previouskey, defaultValue: {}) as Map;

    final List<ExpenseModel> currentMonth = cur.isNotEmpty
        ? cur.values
            .map((value) => (value as List).cast<ExpenseModel>())
            .fold([], (acc, entry) => acc..addAll(entry))
        : [];
    final List<ExpenseModel> previousMonth = prev.isNotEmpty
        ? prev.values
            .map((value) => (value as List).cast<ExpenseModel>())
            .fold([], (acc, entry) => acc..addAll(entry))
        : [];

    return InsightModel(currentMonth, previousMonth);
  }
}
