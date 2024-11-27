import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:flutter/material.dart';

class ExpenseAvatar extends StatelessWidget {
  final ExpenseCategory category;

  const ExpenseAvatar(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconData =
        categoryItems().singleWhere((e) => e.category == category).iconData;
    return Container(
      padding: const EdgeInsets.all(Insets.sm),
      decoration: BoxDecoration(
        color: AppColors.kPrimary,
        borderRadius: Corners.mdBorder,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }
}
