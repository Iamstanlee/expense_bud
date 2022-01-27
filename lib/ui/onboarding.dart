import 'package:expense_tracker/exports.dart';
import 'package:expense_tracker/ui/main.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          children: [
            const Gap(Insets.lg),
            Text(
              '\$',
              style:
                  context.textTheme.headline2!.copyWith(color: AppColors.kDark),
            ),
            const Gap(64),
            const Info(
              'Add entries',
              'Keep track of your income and expenses',
              PhosphorIcons.tray,
            ),
            const Gap(Insets.lg),
            const Info(
              'Check insights',
              'Detailed weekly and monthly charts based on your entries',
              PhosphorIcons.chartLineUp,
            ),
            const Gap(Insets.lg),
            const Info(
              'Make right decisions',
              'And control your money flow',
              PhosphorIcons.target,
            ),
            const Spacer(),
            Button(
              "GET STARTED",
              onTap: () => context.push(const MainPage()),
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
