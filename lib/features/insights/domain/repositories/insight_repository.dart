import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/features/insights/domain/entities/insight.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';

abstract class IInsightRepository {
  Future<Either<Failure, InsightEntity>> getInsightsForPeriod(
    InsightPeriod period,
  );
}
