import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/presentation/choice_settings_item.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class InboxAmountSettingsPage extends StatelessWidget {
  const InboxAmountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final prefs = settingsProvider.preference;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inbox Amount',
          style: context.textTheme.subtitle1,
        ),
        leading: Icon(
          PhosphorIcons.caretLeft,
          color: AppColors.kDark,
        ).onTap(() => context.pop()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.md),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int i) {
            final inboxAmount = InboxAmount.values[i];
            return ChoiceSettingItem(
              title: inboxAmount.title,
              selected: inboxAmount == prefs.inboxAmount,
              onChanged: () => settingsProvider
                  .updateUserPref(prefs.copyWith(inboxAmount: inboxAmount)),
            );
          },
          separatorBuilder: (BuildContext context, int i) => const Divider(
            height: 1.2,
          ),
          itemCount: InboxAmount.values.length,
        ),
      ),
    );
  }
}
