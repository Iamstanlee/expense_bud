import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/core/widgets/state.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:expense_bud/features/insights/presentation/insight_expense_item.dart';
import 'package:expense_bud/features/insights/presentation/insight_header.dart';
import 'package:expense_bud/features/insights/presentation/provider/insights_provider.dart';
import 'package:expense_bud/features/insights/presentation/select_insight_period.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  _InsightsPageState createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  @override
  void initState() {
    super.initState();
    context.read<InsightsProvider>().getInsights();
  }

  @override
  Widget build(BuildContext context) {
    final insightsProvider = context.watch<InsightsProvider>();
    final asyncValueOfInsight = insightsProvider.asyncValueOfInsight;
    final insightPeriod = insightsProvider.insightPeriod;

    final settingsProvider = context.watch<SettingsProvider>();
    final money = settingsProvider.money;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              insightPeriod.title,
              style: context.textTheme.subtitle1,
            ),
            const Gap(4),
            Icon(
              PhosphorIcons.caretDown,
              color: AppColors.kDark,
            )
          ],
        ).onTap(
          () => showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => const SelectInsightPeriod(),
          ),
        ),
        centerTitle: true,
      ),
      body: asyncValueOfInsight.when(
        loading: (_) => const Center(child: Text("Caricamento in corso...")),
        done: (insight) {
          final map =
              insight.sortedMapOfCategoryToPairOfAmountAndNumOfEntries();
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              CupertinoSliverRefreshControl(
                onRefresh: () async => insightsProvider.getInsights(),
              ),
              if (insight.isEmpty)
                const SliverFillRemaining(
                  child: NoDataOrError("Nessun dato da analizzare"),
                )
              else
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Insets.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InsightHeader(
                              percentageIncOrDec:
                                  insight.percentageIncreaseOrDec,
                              increasedFromLastInsightPeriod:
                                  insight.increasedFromLastInsightPeriod,
                              total: money.formatValue(insight.total),
                              splinePoints: insight.splinePoints(),
                            ),
                            Gap.md,
                            if (settingsProvider.preference.showCharts) ...[
                              Text(
                                "PERFORMANCE CHART",
                                style: context.textTheme.caption,
                              ),
                              Gap.md,
                              SizedBox(
                                height: 170,
                                child: PieChart(
                                  PieChartData(
                                    sections: map.keys.map(
                                      (key) {
                                        final pair = map[key]!;
                                        final value =
                                            ((pair.left / insight.total) * 100)
                                                .floorToDouble();
                                        return PieChartSectionData(
                                          value: value,
                                          color: key.color,
                                          title: "$value%",
                                          showTitle: value >= 5,
                                          titleStyle: context
                                              .textTheme.bodyMedium!
                                              .copyWith(
                                            color: AppColors.kDark,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    sectionsSpace: 3,
                                  ),
                                  swapAnimationDuration:
                                      const Duration(milliseconds: 200),
                                  swapAnimationCurve: Curves.linear,
                                ),
                              ),
                              Gap.lg,
                            ],
                            Text(
                              "EXPENSE BREAKDOWN",
                              style: context.textTheme.caption,
                            ),
                            Gap.md,
                            ...map.keys.map(
                              (key) => ExpenseItem(
                                categoryItem: key,
                                totalAmount: money.formatValue(map[key]!.left),
                                numOfEntries: map[key]!.right,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ],
          );
        },
        error: (err) => NoDataOrError(err!),
      ),
    );
  }
}
