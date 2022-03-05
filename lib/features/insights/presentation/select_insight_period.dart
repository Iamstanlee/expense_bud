import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/features/insights/domain/entities/insight_period.dart';
import 'package:expense_bud/features/insights/presentation/provider/insights_provider.dart';
import 'package:expense_bud/features/settings/presentation/choice_settings_item.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SelectInsightPeriod extends StatelessWidget {
  const SelectInsightPeriod({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final insightsProvider = context.watch<InsightsProvider>();
    final insightPeriod = insightsProvider.insightPeriod;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Insight Period',
          style: context.textTheme.subtitle1,
        ),
        leading: Icon(
          PhosphorIcons.x,
          color: AppColors.kDark,
        ).onTap(() => context.pop()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int i) {
            final period = InsightPeriod.values[i];
            return ChoiceSettingItem(
              title: period.title,
              selected: insightPeriod == period,
              onChanged: () {
                insightsProvider.insightPeriod = period;
                insightsProvider.getInsights();
                context.pop();
              },
            );
          },
          separatorBuilder: (BuildContext context, int i) => const Divider(
            height: 1.2,
          ),
          itemCount: InsightPeriod.values.length,
        ),
      ),
    );
  }
}
