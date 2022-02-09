import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/expense_category.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';

class ExpenseItemGridSheet extends StatelessWidget {
  final ExpenseCategoryItem item;
  const ExpenseItemGridSheet(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.getHeight(0.5),
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(Insets.md, 0, Insets.md, Insets.lg),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: Corners.lgBorder,
      ),
      padding: const EdgeInsets.all(Insets.md),
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Expenses',
                style: context.textTheme.subtitle1,
              ),
              Gap.md,
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: kExpenseCategoryItems
                    .map((e) => _Item(
                          e,
                          isSelected: item == e,
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final ExpenseCategoryItem item;
  final bool isSelected;
  const _Item(this.item, {this.isSelected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = isSelected ? AppColors.kPrimary : AppColors.kDark;
    return Column(
      children: [
        Icon(
          item.iconData,
          size: IconSizes.lg,
          color: _color,
        ),
        Gap.sm,
        Text(
          item.title,
          style: context.textTheme.bodyText2!.copyWith(color: _color),
        )
      ],
    ).onTap(() => context.pop(item));
  }
}
