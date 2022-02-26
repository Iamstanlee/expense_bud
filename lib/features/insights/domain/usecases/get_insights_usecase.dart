import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/domain/usecases/usecase.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/features/insights/domain/entities/insight.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:expense_bud/features/insights/domain/repositories/insight_repository.dart';

class GetInsightsUsecase
    implements UsecaseOfFuture<InsightEntity, InsightPeriod> {
  final IInsightRepository _insightRepository;
  GetInsightsUsecase(this._insightRepository);

  @override
  Future<Either<Failure, InsightEntity>> call(period) {
    return _insightRepository.getInsightsForPeriod(period);
  }
}
