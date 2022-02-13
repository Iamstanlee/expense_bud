import 'package:expense_bud/config/config.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:expense_bud/core/widgets/state.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsightsPage extends StatefulWidget {
  const InsightsPage({Key? key}) : super(key: key);

  @override
  _InsightsPageState createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'This month',
                style: context.textTheme.subtitle1,
              ),
              const Gap(4),
              Icon(
                PhosphorIcons.caretDown,
                color: AppColors.kDark,
              )
            ],
          ),
          centerTitle: true,
        ),
        body: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: NoDataOrError("Coming soon"),
            )
          ],
        ));
  }
}
