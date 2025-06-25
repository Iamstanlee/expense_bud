import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/utils/platform.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/features/expense/presentation/add_entry.dart';
import 'package:expense_bud/features/expense/presentation/expense_tab.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ExpenseProvider>().getEntries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            expandedHeight: 220,
            backgroundColor: AppColors.kPrimary,
            actions: [
              IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => const AddEntryPage(),
                  );
                },
                icon: const Icon(
                  PhosphorIconsFill.plusCircle,
                  color: Colors.white,
                ),
              )
            ],
            flexibleSpace: const _FlexibleSpaceBar(),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              const ExpenseTab(),
            ],
          )),
        ],
      ),
    );
  }
}

class _FlexibleSpaceBar extends StatelessWidget {
  const _FlexibleSpaceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expenseProvider = context.watch<ExpenseProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final prefs = settingsProvider.preference;
    final money = settingsProvider.money;

    int inboxAmount = 0;
    int expenseAmount = 0;
    int incomeAmount = 0;

    switch (prefs.inboxAmount) {
      case InboxAmount.today:
        inboxAmount = expenseProvider.getDailyTotal();
        expenseAmount = expenseProvider.getDailyExpenses();
        incomeAmount = expenseProvider.getDailyIncome();
        break;
      case InboxAmount.month:
        inboxAmount = expenseProvider.getMonthlyTotal();
        break;
      default:
        inboxAmount = expenseProvider.getWeeklyTotal();
    }

    String timeFrameText = '';
    switch (prefs.inboxAmount) {
      case InboxAmount.today:
        timeFrameText = 'Today';
        break;
      case InboxAmount.week:
        timeFrameText = 'This Week';
        break;
      case InboxAmount.month:
        timeFrameText = 'This Month';
        break;
    }

    return LayoutBuilder(builder: (context, constraints) {
      final top = constraints.biggest.height;
      final expandRatio =
          ((top - kToolbarHeight) / (220 - kToolbarHeight)).clamp(0.0, 1.0);
      return FlexibleSpaceBar(
        background: Container(
          color: AppColors.kPrimary,
          padding: const EdgeInsets.only(top: 120, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Balance',
                style: context.textTheme.titleMedium!.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                money.formatValue(inboxAmount),
                style: context.textTheme.displaySmall!.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeFrameText,
                style: context.textTheme.bodySmall!.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: _FinanceSummaryItem(
                        title: 'Income',
                        amount: money.formatValue(incomeAmount),
                        color: Colors.green,
                        icon: PhosphorIconsRegular.arrowUp,
                      ),
                    ),
                    Gap.md,
                    Expanded(
                      child: _FinanceSummaryItem(
                        title: 'Expenses',
                        amount: money.formatValue(expenseAmount),
                        color: Colors.redAccent,
                        icon: PhosphorIconsRegular.arrowDown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        title: AnimatedOpacity(
          opacity: 1 - expandRatio,
          duration: const Duration(milliseconds: 300),
          child: Text(
            money.formatValue(inboxAmount),
            style: context.textTheme.titleMedium!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}

class _FinanceSummaryItem extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final IconData icon;

  const _FinanceSummaryItem({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 6),
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 6),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$title\n',
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.2,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  TextSpan(
                    text: amount,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
