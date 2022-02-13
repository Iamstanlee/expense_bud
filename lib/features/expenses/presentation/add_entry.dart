import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/money_formatter.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/expense_avatar.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expenses/domain/entities/expense.dart';
import 'package:expense_bud/features/expenses/presentation/expense_grid_sheet.dart';
import 'package:expense_bud/features/expenses/presentation/onscreen_keyboard.dart';
import 'package:expense_bud/features/expenses/presentation/provider/expense_provider.dart';
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
  final MoneyFormatter _defaultMoneyFormatter = MoneyFormatter.instance;

  String _amount = "";
  ExpenseCategoryItem _categoryItem = kExpenseCategoryItems.first;

  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          microseconds: 2000,
        ));
    _animation = Tween<double>(begin: 1, end: 1.08).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceIn,
      ),
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final moneyFormatter = expenseProvider.moneyFormatter;
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
                          PhosphorIcons.x,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Add Transaction',
                        style: context.textTheme.subtitle1,
                      ),
                    ],
                  ),
                  Gap.md,
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.kPrimary,
                          borderRadius: Corners.lgBorder,
                        ),
                        padding: const EdgeInsets.all(Insets.md),
                        child: Center(
                          child: Text(
                            moneyFormatter.name,
                            style: context.textTheme.headline6!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Gap.md,
                      Expanded(
                        child: ScaleTransition(
                          scale: _animation,
                          child: AutoSizeText(
                            _amount.isEmpty
                                ? '0.0'
                                : _defaultMoneyFormatter.stringToMoney(_amount),
                            style: context.textTheme.headline3!
                                .copyWith(color: AppColors.kDark),
                            maxLines: 1,
                          ),
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
                        builder: (context) =>
                            ExpenseItemGridSheet(_categoryItem),
                      );
                      if (value != null) {
                        setState(() => _categoryItem = value);
                      }
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            OnScreenKeyboard(
              onChange: (value) {
                setState(() {
                  _amount = value;
                  _controller.forward();
                });
              },
              onEnter: (value) async {
                final thisInstant = DateTime.now().toIso8601String();
                final ExpenseEntity entry = ExpenseEntity(
                  createdAt: thisInstant,
                  updatedAt: thisInstant,
                  category: _categoryItem.category,
                  amount: _amount.toFloat(),
                );
                await expenseProvider.createExpenseEntry(entry);
                context.pop();
              },
            ),
          ],
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
        ExpenseAvatar(item.category),
        Gap.md,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                item.title,
                maxLines: 1,
                style: context.textTheme.subtitle1!
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
          child: Icon(PhosphorIcons.caretRight, color: AppColors.kDark),
        )
      ],
    ).onTap(
      () => onChanged(item),
    );
  }
}
