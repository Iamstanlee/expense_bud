import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/expense_avatar.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
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

    return Dismissible(
      key: Key(_expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Expense'),
              content: const Text('Are you sure you want to delete this expense?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        context.read<ExpenseProvider>().deleteExpenseEntry(_expense.id);
      },
      child: Padding(
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
                      style: context.textTheme.labelMedium!.copyWith(
                        fontSize: FontSizes.s16,
                      ),
                    ),
                    if (showEntryDate)
                      Text(
                        _dateFormatter.relativeToNow(_expense.createdAt),
                        style: context.textTheme.labelSmall,
                      ),
                  ],
                )
              ],
            ),
            const Spacer(),
            Text(
              money.formatValue(_expense.amount),
              style: context.textTheme.titleSmall!.copyWith(
                color: const Color(0xFFE58D67),
              ),
            ),
            Gap.sm,
            IconButton(
              onPressed: () async {
                final shouldDelete = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Expense'),
                      content: const Text('Are you sure you want to delete this expense?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
                if (shouldDelete == true) {
                  context.read<ExpenseProvider>().deleteExpenseEntry(_expense.id);
                }
              },
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
