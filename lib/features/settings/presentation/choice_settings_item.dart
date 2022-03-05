import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChoiceSettingItem extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onChanged;
  const ChoiceSettingItem(
      {required this.title,
      required this.onChanged,
      required this.selected,
      Key? key})
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
          if (selected) Icon(PhosphorIcons.check, color: AppColors.kDark)
        ],
      ),
    ).onTap(() => onChanged());
  }
}
