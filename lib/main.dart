import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/config/theme.dart';
import 'package:expense_tracker/core/onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      title: AppStrings.kTitle,
      home: const OnboardingPage(),
    );
  }
}
