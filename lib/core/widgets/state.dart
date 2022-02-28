import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum Variant { noData, error }

class NoDataOrError extends StatelessWidget {
  final String msg;
  final Variant variant;

  const NoDataOrError(this.msg, {this.variant = Variant.noData, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        variant == Variant.noData ? AppColors.kGrey : AppColors.kError;
    return Padding(
      padding: const EdgeInsets.all(Insets.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              borderRadius: Corners.mdBorder,
              color: color.withOpacity(0.2),
            ),
            child: Icon(
              variant == Variant.noData
                  ? PhosphorIcons.rocketFill
                  : PhosphorIcons.finnTheHumanFill,
              color: color,
              size: IconSizes.lg,
            ),
          ),
          Gap.md,
          Text(
            msg,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
