import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/presentation/app.dart';
import 'package:expense_bud/core/utils/currencies.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/button.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/settings/domain/entities/currency.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ChooseCurrencyPage extends StatefulWidget {
  const ChooseCurrencyPage({Key? key}) : super(key: key);

  @override
  _ChooseCurrencyPageState createState() => _ChooseCurrencyPageState();
}

class _ChooseCurrencyPageState extends State<ChooseCurrencyPage> {
  CurrencyEntity? selectedCurrency;

  @override
  Widget build(BuildContext context) {
    final list = currencyList();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          PhosphorIcons.caretLeft,
          color: AppColors.kDark,
        ).onTap(() => context.pop()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.md),
              child: Text(
                'Chooose Your Preferred Currency',
                style: context.textTheme.headlineMedium!.copyWith(
                  fontSize: FontSizes.s24,
                  color: AppColors.kDark,
                ),
              ),
            ),
            Gap.md,
            Expanded(
                child: Wrap(
              spacing: Insets.md,
              runSpacing: Insets.md,
              children: list
                  .map(
                    (currency) => CurrencyListItem(
                      title: currency.name,
                      onChanged: () =>
                          setState(() => selectedCurrency = currency),
                      selected: currency == selectedCurrency,
                    ),
                  )
                  .toList(),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.md),
              child: Button("CONTINUE",
                  onTap: selectedCurrency != null
                      ? () {
                          final settings = context.read<SettingsProvider>();
                          final prefs = settings.preference;
                          settings.updateUserPref(
                            prefs.copyWith(
                              onboardingComplete: true,
                              currency: selectedCurrency,
                            ),
                          );
                          context.pushOff(const AppPage());
                        }
                      : null),
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}

class CurrencyListItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onChanged;
  const CurrencyListItem(
      {required this.title,
      required this.onChanged,
      required this.selected,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.md,
        vertical: Insets.sm,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.kPrimary : Colors.white,
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: AppColors.kGrey200,
          width: 1.4,
        ),
      ),
      child: Text(
        title,
        style: context.textTheme.bodyLarge!.copyWith(
          color: selected ? Colors.white : AppColors.kDark,
        ),
      ),
    ).onTap(() => onChanged());
  }
}
