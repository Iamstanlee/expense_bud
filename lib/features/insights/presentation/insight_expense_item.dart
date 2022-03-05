import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final ExpenseCategoryItem categoryItem;
  final String totalAmount;
  final int numOfEntries;
  const ExpenseItem(
      {required this.categoryItem,
      required this.totalAmount,
      required this.numOfEntries,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.sm),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                height: 8,
                width: 8,
                child: ColoredBox(
                  color: categoryItem.color,
                ),
              ),
              Gap.md,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryItem.title,
                    style: context.textTheme.bodyText1!
                        .copyWith(fontSize: FontSizes.s16),
                  ),
                  Text(
                    "$numOfEntries ${'entry'.pluralize(numOfEntries)}",
                    style: context.textTheme.caption,
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            totalAmount,
            style: context.textTheme.bodyText2!.copyWith(
              color: const Color(0xFFE58D67),
            ),
          )
        ],
      ),
    );
  }
}
