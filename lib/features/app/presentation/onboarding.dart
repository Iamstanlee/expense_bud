import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/button.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/app/presentation/app.dart';
import 'package:expense_bud/features/app/presentation/providers/preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

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
            Text(
              AppStrings.kTitle,
              style:
                  context.textTheme.headline4!.copyWith(color: AppColors.kDark),
            ),
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
              'And control your money flow',
              PhosphorIcons.medal,
            ),
            const Spacer(),
            Button(
              "GET STARTED",
              onTap: () {
                context.read<PreferenceProvider>().completeOnboarding();
                context.push(const AppPage());
              },
            ),
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
                style: context.textTheme.subtitle1,
              ),
              Gap.sm,
              Text(
                subtitle,
                style: context.textTheme.subtitle1!
                    .copyWith(color: AppColors.kGrey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
