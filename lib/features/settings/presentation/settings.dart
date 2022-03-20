import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/button.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/presentation/currency_settings.dart';
import 'package:expense_bud/features/settings/presentation/inbox_amount_settings.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();
    final prefs = settingsProvider.preference;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Impostazioni',
          style: context.textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Gap.md,
            SettingHeader(
              "Spese e voci",
              children: [
                DefaultSettingItem(
                  'Totale mostrato',
                  trailing: prefs.inboxAmount.title,
                  onTap: () => context.push(const InboxAmountSettingsPage()),
                ),
                DefaultSettingItem(
                  'Valuta',
                  trailing: prefs.currency.name,
                  onTap: () => context.push(const CurrencySettingsPage()),
                ),
                SwitchSettingItem(
                  'Mostra data',
                  value: prefs.showEntryDate,
                  onChanged: (value) => settingsProvider.updateUserPref(
                    prefs.copyWith(showEntryDate: value),
                  ),
                ),
                DefaultSettingItem(
                  'Cancella i dati',
                  textColor: AppColors.kError,
                  onTap: () => showCupertinoModalPopup(
                    context: context,
                    builder: (context) => DeleteBottomSheet(onDelete: () async {
                      context.read<ExpenseProvider>().eraseEntries();
                      context.pop();
                    }),
                  ),
                ),
              ],
            ),
            Gap.md,
            SettingHeader("Intuizioni e grafici", children: [
              SwitchSettingItem(
                'Mostra grafici',
                value: prefs.showCharts,
                onChanged: (value) => settingsProvider.updateUserPref(
                  prefs.copyWith(showCharts: value),
                ),
              ),
            ]),
            Gap.md,
            SettingHeader("Info app", children: [
              const DefaultSettingItem('Versione', trailing: "0.2.0.beta"),
              DefaultSettingItem(
                'Feedback',
                onTap: () => AppStrings.kFeedbackUrl.launchAsUrl(),
              ),
              DefaultSettingItem(
                'Privacy Policy',
                onTap: () => AppStrings.kPrivacyPolicyUrl.launchAsUrl(),
              ),
            ]),
            const Gap(50)
          ],
        ),
      ),
    );
  }
}

class SettingHeader extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingHeader(this.title, {required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.sm),
            child: Text(
              title,
              style:
                  context.textTheme.bodyText1!.copyWith(color: Colors.black54),
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) => children[i],
            separatorBuilder: (BuildContext context, int i) => const Divider(
              height: 1.2,
            ),
            itemCount: children.length,
          )
        ],
      ),
    );
  }
}

class DefaultSettingItem extends StatelessWidget {
  final String title;
  final String? trailing;
  final Function? onTap;
  final Color? textColor;
  const DefaultSettingItem(this.title,
      {this.onTap, this.textColor, this.trailing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.md,
        vertical: Insets.sm,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.textTheme.bodyText1!
                .copyWith(color: textColor ?? AppColors.kDark),
          ),
          Row(
            children: [
              Text(
                trailing ?? "",
                style: context.textTheme.bodyText2!.copyWith(
                  color: AppColors.kGrey,
                ),
              ),
              Gap.sm,
              if (onTap != null) const Icon(PhosphorIcons.caretRight)
            ],
          )
        ],
      ),
    ).onTap(() => onTap?.call());
  }
}

class SwitchSettingItem extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const SwitchSettingItem(this.title,
      {required this.value, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.md,
        vertical: Insets.sm,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                context.textTheme.bodyText1!.copyWith(color: AppColors.kDark),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: (value) => onChanged(value),
            activeColor: AppColors.kPrimary,
          ),
        ],
      ),
    );
  }
}

class DeleteBottomSheet extends StatelessWidget {
  final VoidCallback? onDelete;
  const DeleteBottomSheet({this.onDelete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Stai per eliminare tutte le voci su questa app, questo non può essere annullato",
              textAlign: TextAlign.center,
              style: context.textTheme.caption!,
            ),
            Gap.md,
            Button(
              "ELIMINA",
              color: AppColors.kError,
              onTap: () => onDelete?.call(),
            ),
            Gap.md,
            const Text('ANNULLA').onTap(() => context.pop()),
            Gap.md,
          ],
        ),
      ),
    );
  }
}
