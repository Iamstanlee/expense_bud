import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/presentation/choose_currency.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/button.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            const Gap(64),
            const Text(
              'Expense Bud',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
            const Text(
              'No.1 expense tracker app',
              style: TextStyle(fontSize: 14),
            ),
            const Gap(64),
            const Info(
              'Record expenses and spendings',
              'Keep track of your income, expenses & spendings',
              PhosphorIconsRegular.mastodonLogo,
            ),
            const Gap(Insets.lg),
            const Info(
              'Check insights',
              'Get detailed insights into your spending habits and control your money flow!',
              PhosphorIconsRegular.chartPieSlice,
            ),
            const Gap(Insets.lg),
            const Info(
              'Make right decisions',
              'Stay on top of your game',
              PhosphorIconsRegular.medalMilitary,
            ),
            const Spacer(),
            Button(
              "GET STARTED",
              onTap: () => context.push(const ChooseCurrencyPage()),
            ),
            const Gap(Insets.lg),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;

  const Info(this.title, this.subtitle, this.icon, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: IconSizes.lg,
          color: AppColors.kPrimary,
        ),
        Gap.md,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap.sm,
              Text(
                subtitle,
                style: context.textTheme.titleSmall!
                    .copyWith(color: AppColors.kGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
