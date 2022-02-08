import 'package:auto_size_text/auto_size_text.dart';
import 'package:expense_tracker/config/theme.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
import 'package:expense_tracker/core/widgets/gap.dart';
import 'package:expense_tracker/features/expenses/presentation/add_entry.dart';
import 'package:expense_tracker/features/expenses/presentation/expense_tab.dart';
import 'package:expense_tracker/features/expenses/presentation/provider/expense_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
            actions: [
              IconButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => const AddEntryPage(),
                  );
                },
                icon: const Icon(
                  PhosphorIcons.plusFill,
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
    final moneyFormatter = expenseProvider.moneyFormatter;
    final currentDayEntriesTotal = expenseProvider.currentDayEntriesTotal;

    return FlexibleSpaceBar(
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spent this week',
            style: context.textTheme.overline!.copyWith(
              color: Colors.white60,
              fontSize: FontSizes.s8,
            ),
          ),
          const Gap(2),
          AutoSizeText(
            moneyFormatter.stringToMoney(currentDayEntriesTotal.toString()),
            style: context.textTheme.headline4!
                .copyWith(color: Colors.white, fontSize: FontSizes.s28),
            maxLines: 1,
          ),
        ],
      ),
      titlePadding: const EdgeInsets.only(
        left: Insets.lg,
        right: Insets.lg,
        bottom: Insets.lg,
      ),
    );
  }
}
