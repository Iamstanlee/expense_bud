import 'package:expense_tracker/config/theme.dart';
import 'package:expense_tracker/core/expense_category.dart';
import 'package:expense_tracker/core/utils/money_converter.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/widgets/expense_avatar.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpenseListItem extends StatelessWidget {
  final ExpenseEntity _expense;
  final MoneyFormatter _moneyFormatter = MoneyFormatter.instance;

  ExpenseListItem(this._expense, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _categoryItem = kExpenseCategoryItems
        .singleWhere((e) => e.category == _expense.category);

    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Row(
            children: [
              ExpenseAvatar(_categoryItem.category),
              Gap.md,
              Text(
                _categoryItem.title,
                style: context.textTheme.bodyText1!
                    .copyWith(fontSize: FontSizes.s16),
              ),
            ],
          ),
          const Spacer(),
          Text(
            _moneyFormatter.stringToMoney(_expense.amount.toString()),
            style: context.textTheme.bodyText2!.copyWith(
              color: const Color(0xFFE58D67),
            ),
          )
        ],
      ),
    );
  }
}
