import 'package:expense_bud/core/utils/async_value.dart';
import 'package:expense_bud/features/insights/domain/entities/insight.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:expense_bud/features/insights/domain/usecases/get_insights_usecase.dart';
import 'package:flutter/foundation.dart';

class InsightsProvider with ChangeNotifier {
  final GetInsightsUsecase _getInsightsUsecase;
  InsightsProvider({required GetInsightsUsecase getInsightsUsecase})
      : _getInsightsUsecase = getInsightsUsecase;

  InsightPeriod _insightPeriod = InsightPeriod.thisMonth;
  InsightPeriod get insightPeriod => _insightPeriod;
  set insightPeriod(InsightPeriod value) {
    _insightPeriod = value;
    notifyListeners();
  }

  AsyncValue<InsightEntity> _asyncValueOfInsight = AsyncValue.loading();

  AsyncValue<InsightEntity> get asyncValueOfInsight => _asyncValueOfInsight;
  set asyncValueOfInsight(AsyncValue<InsightEntity> value) {
    _asyncValueOfInsight = value;
    notifyListeners();
  }

  void getInsights() async {
    final failureOrInsight = await _getInsightsUsecase(insightPeriod);
    failureOrInsight.fold((failure) => null, (data) {
      asyncValueOfInsight = AsyncValue.done(data);
    });
  }
}
