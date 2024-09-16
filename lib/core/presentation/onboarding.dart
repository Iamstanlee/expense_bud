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
            Image.asset(AppImages.logo, height: 24),
            const Gap(Insets.lg),
            const Info(
              'Add entries',
              'Keep track of your income and expenses',
              PhosphorIcons.tray,
            ),
            const Gap(Insets.lg),
            const Info(
              'Check insights',
              'Detailed weekly and monthly charts based on your entries',
              PhosphorIcons.lightning,
            ),
            const Gap(Insets.lg),
            const Info(
              'Make right decisions',
              'Control your money flow and stay on top of your game',
              PhosphorIcons.medal,
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
        ),
        Gap.md,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleMedium,
              ),
              Gap.sm,
              Text(
                subtitle,
                style: context.textTheme.titleMedium!
                    .copyWith(color: AppColors.kGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
