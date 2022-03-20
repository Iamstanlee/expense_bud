import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/presentation/app.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/button.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
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
            Image.asset(AppImages.logo, height: 24),
            const Gap(Insets.lg),
            const Info(
              'Aggiungi voci',
              'Tieni traccia dei tuoi redditi e spese',
              PhosphorIcons.tray,
            ),
            const Gap(Insets.lg),
            const Info(
              'Controlla le intuizioni',
              'Grafici settimanali e mensili dettagliati in base alle voci',
              PhosphorIcons.lightning,
            ),
            const Gap(Insets.lg),
            const Info(
              'Fare decisioni giuste',
              'Controlla il tuo flusso di denaro e rimani in cima al tuo gioco',
              PhosphorIcons.medal,
            ),
            const Spacer(),
            Button(
              "INIZIARE",
              onTap: () {
                final settings = context.read<SettingsProvider>();
                final prefs = settings.preference;
                settings
                    .updateUserPref(prefs.copyWith(onboardingComplete: true));
                context.pushOff(const AppPage());
              },
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
