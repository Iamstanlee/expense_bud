import 'package:expense_bud/core/data/mappers/expense.dart';
import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/features/insights/domain/entities/insight.dart';

class InsightModel extends InsightEntity {
  InsightModel(
    List<ExpenseModel> cur,
    List<ExpenseModel> prev,
  ) : super(
          cur.map((e) => e.toEntity()).toList(),
          prev.map((e) => e.toEntity()).toList(),
        );

}
