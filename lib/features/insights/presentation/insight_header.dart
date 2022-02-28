import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_bud/config/config.dart';
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
        ? PhosphorIcons.arrowUp
        : PhosphorIcons.arrowDown;

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AutoSizeText(
                total,
                style: context.textTheme.headline4!
                    .copyWith(color: AppColors.kDark, fontSize: FontSizes.s28),
                maxLines: 1,
              ),
              Gap.sm,
              Container(
                padding: const EdgeInsets.all(2),
                color: color.withOpacity(0.1),
                child: Row(
                  children: [
                    Icon(
                      iconData,
                      size: 14,
                      color: color,
                    ),
                    const Gap(2),
                    Text(
                      '$percentageIncOrDec%',
                      style: context.textTheme.caption!.copyWith(color: color),
                    )
                  ],
                ),
              )
            ],
          ),
          Gap.md,
          Expanded(
            child: FittedBox(
              child: SizedBox(
                height: 50,
                width: 100,
                child: CustomPaint(
                  painter: SplineLinePainter(color, splinePoints),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplineLinePainter extends CustomPainter {
  final Color color;
  final List<double> splinePoints;
  SplineLinePainter(this.color, this.splinePoints);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;
    // TODO: try draw line?
    canvas.drawPoints(
      PointMode.polygon,
      [
        Offset(0, size.height / 2),
        ...List.generate(
          splinePoints.length,
          (i) {
            final point = splinePoints[i];
            return Offset(
              i * size.width / splinePoints.length,
              point * size.height,
            );
          },
        )
      ],
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
