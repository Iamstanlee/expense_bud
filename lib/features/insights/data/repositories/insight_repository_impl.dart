import 'package:expense_bud/features/insights/data/datasources/local_datasource.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:expense_bud/features/insights/domain/entities/insight.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_bud/features/insights/domain/repositories/insight_repository.dart';

class InsightRepository implements IInsightRepository {
  final IInsightLocalDataSource _insightLocalDataSource;
  InsightRepository(this._insightLocalDataSource);
  @override
  Future<Either<Failure, InsightEntity>> getInsightsForPeriod(
    InsightPeriod period,
  ) async {
    try {
      final insight =
          await _insightLocalDataSource.getInsightsForPeriod(period);
      return Right(
        InsightEntity(insight.cur, insight.prev),
      );
    } catch (e) {
      return Left(CacheGetFailure());
    }
  }
}
