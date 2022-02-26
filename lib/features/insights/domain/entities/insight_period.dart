import 'package:expense_bud/core/failure/exceptions.dart';

enum InsightPeriod { last3Days, last7Days, last14Days, thisMonth, lastMonth }

extension InsightPeriodExtension on InsightPeriod {
  String get title {
    switch (this) {
      case InsightPeriod.last7Days:
        return "Last 7 Days";
      case InsightPeriod.last14Days:
        return "Last 14 Days";
      case InsightPeriod.thisMonth:
        return "This Month";
      case InsightPeriod.lastMonth:
        return "Last Month";
      default:
        return "Last 3 Days";
    }
  }

  R map<R>({
    required R Function() last3Days,
    required R Function() last7Days,
    required R Function() last14Days,
    required R Function() thisMonth,
    required R Function() lastMonth,
  }) {
    switch (this) {
      case InsightPeriod.last3Days:
        return last3Days();
      case InsightPeriod.last7Days:
        return last7Days();
      case InsightPeriod.last14Days:
        return last14Days();
      case InsightPeriod.thisMonth:
        return thisMonth();
      case InsightPeriod.lastMonth:
        return lastMonth();
      default:
        throw InvalidArgException();
    }
  }
}
