import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsightHeader extends StatelessWidget {
  final String total;
  final double percentageIncOrDec;
  final bool increasedFromLastInsightPeriod;
  final List<double> splinePoints;

  const InsightHeader({
    required this.total,
    required this.percentageIncOrDec,
    required this.increasedFromLastInsightPeriod,
    required this.splinePoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        increasedFromLastInsightPeriod ? AppColors.kError : Colors.green;
    final iconData = increasedFromLastInsightPeriod
        ? PhosphorIconsRegular.arrowUpRight
        : PhosphorIconsRegular.arrowDownRight;

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AutoSizeText(
                total,
                style: context.textTheme.headlineMedium!.copyWith(
                  color: color,
                  fontSize: FontSizes.s24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
              Gap.sm,
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.08),
                  borderRadius: Corners.mdBorder,
                ),
                child: Row(
                  children: [
                    Icon(
                      iconData,
                      size: 12,
                      color: color,
                    ),
                    const Gap(2),
                    Text(
                      '$percentageIncOrDec%',
                      style:
                          context.textTheme.labelSmall!.copyWith(color: color),
                    ),
                  ],
                ),
              )
            ],
          ),
          Gap.md,
        ],
      ),
    );
  }
}
