import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/widgets/gap.dart';
import 'package:flutter/material.dart';

class InboxAmountSettings extends StatelessWidget {
  const InboxAmountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inbox Amount',
          style: context.textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Gap.lg,
        ],
      ),
    );
  }
}
