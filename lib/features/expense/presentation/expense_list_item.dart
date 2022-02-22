import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/expense_avatar.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expense/domain/entities/expense.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListItem extends StatelessWidget {
  ExpenseListItem(this._expense, {Key? key}) : super(key: key);
  final ExpenseEntity _expense;
  final DateFormatter _dateFormatter = DateFormatter.instance;

  @override
  Widget build(BuildContext context) {
    final _categoryItem =
        categoryItems().singleWhere((e) => e.category == _expense.category);
    final money = context.watch<SettingsProvider>().money;
    final showEntryDate =
        context.watch<SettingsProvider>().preference.showEntryDate;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Row(
            children: [
              ExpenseAvatar(_categoryItem.category),
              Gap.md,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _categoryItem.title,
                    style: context.textTheme.bodyText1!
                        .copyWith(fontSize: FontSizes.s16),
                  ),
                  if (showEntryDate)
                    Text(
                      "Added ${_dateFormatter.relativeToNow(_expense.createdAt)}",
                      style: context.textTheme.caption,
                    ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            money.formatValue(_expense.amount),
            style: context.textTheme.bodyText2!.copyWith(
              color: const Color(0xFFE58D67),
            ),
          )
        ],
      ),
    );
  }
}
