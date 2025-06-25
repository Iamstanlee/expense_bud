import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/expense_avatar.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expense/presentation/expense_grid_sheet.dart';
import 'package:expense_bud/features/expense/presentation/onscreen_keyboard.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class AddEntryPage extends StatefulWidget {
  const AddEntryPage({Key? key}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  TransactionType _transactionType = TransactionType.expense;
  ExpenseCategoryItem _categoryItem =
      categoryItemsByType(TransactionType.expense)[0];

  int amount = 0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          microseconds: 2000,
        ));
    super.initState();
  }

  void _updateTransactionType(TransactionType type) {
    setState(() {
      _transactionType = type;
      _categoryItem = categoryItemsByType(type)[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final money =
        context.watch<SettingsProvider>().money.formatWithEmptyString();
    return SizedBox(
      height: context.getHeight(0.9),
      child: Material(
        borderRadius: const BorderRadius.only(
          topLeft: Corners.lgRadius,
          topRight: Corners.lgRadius,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.lg),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          PhosphorIconsRegular.x,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Add Transaction',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Gap.md,
                  // Transaction type selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildTransactionTypeButton(
                        context,
                        'Expense',
                        TransactionType.expense,
                        Colors.redAccent,
                      ),
                      const SizedBox(width: 16),
                      _buildTransactionTypeButton(
                        context,
                        'Income',
                        TransactionType.income,
                        Colors.green,
                      ),
                    ],
                  ),
                  Gap.md,
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          money.formatValue(amount),
                          style: context.textTheme.displaySmall!.copyWith(
                            color: _transactionType == TransactionType.expense
                                ? Colors.redAccent
                                : Colors.green,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Gap.lg,
                  ExpenseRow(
                    _categoryItem,
                    onChanged: (value) async {
                      final value = await showCupertinoModalPopup(
                        context: context,
                        builder: (context) => ExpenseItemGridSheet(
                            _categoryItem, _transactionType),
                      );
                      if (value != null) {
                        setState(() => _categoryItem = value);
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            OnScreenKeyboard(
              onChange: (value) {
                setState(() {
                  _controller.forward();
                  amount = money.value(value);
                });
              },
              onEnter: () async {
                final thisInstant = DateTime.now().toIso8601String();
                await expenseProvider.createExpenseEntry(TransactionEntity(
                  createdAt: thisInstant,
                  updatedAt: thisInstant,
                  category: _categoryItem.category,
                  amount: amount,
                  transactionType: _transactionType,
                ));
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTypeButton(
    BuildContext context,
    String title,
    TransactionType type,
    Color activeColor,
  ) {
    final isActive = _transactionType == type;
    return GestureDetector(
      onTap: () => _updateTransactionType(type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? activeColor : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? activeColor : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class ExpenseRow extends StatelessWidget {
  final ExpenseCategoryItem item;
  final ValueChanged<ExpenseCategoryItem> onChanged;

  const ExpenseRow(this.item, {required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Insets.xs),
          child: ExpenseAvatar(item.category),
        ),
        Gap.md,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.title,
                maxLines: 1,
                style: context.textTheme.titleMedium!
                    .copyWith(fontSize: FontSizes.s18),
              ),
              Divider(
                color: AppColors.kDark,
                thickness: .9,
              ),
            ],
          ),
        ),
        Gap.md,
        Padding(
          padding: const EdgeInsets.only(bottom: Insets.sm),
          child: Icon(PhosphorIconsRegular.caretRight, color: AppColors.kDark),
        )
      ],
    ).onTap(
      () => onChanged(item),
    );
  }
}
