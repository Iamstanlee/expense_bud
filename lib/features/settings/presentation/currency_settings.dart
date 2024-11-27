import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/currencies.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/features/settings/presentation/choice_settings_item.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class CurrencySettingsPage extends StatelessWidget {
  const CurrencySettingsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final list = currencyList();
    final settingsProvider = context.watch<SettingsProvider>();
    final prefs = settingsProvider.preference;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Currency',
          style: context.textTheme.titleMedium,
        ),
        leading: Icon(
          PhosphorIconsRegular.caretLeft,
          color: AppColors.kDark,
        ).onTap(() => context.pop()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int i) {
            final currency = list[i];
            return ChoiceSettingItem(
              title: currency.name,
              selected: currency == prefs.currency,
              onChanged: () => settingsProvider
                  .updateUserPref(prefs.copyWith(currency: currency)),
            );
          },
          separatorBuilder: (BuildContext context, int i) => const Divider(
            height: 1.2,
          ),
          itemCount: list.length,
        ),
      ),
    );
  }
}
