import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/presentation/app.dart';
import 'package:expense_bud/core/presentation/onboarding.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/insights/presentation/provider/insights_provider.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:expense_bud/injector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseProvider>(create: (context) => getIt()),
        ChangeNotifierProvider<InsightsProvider>(create: (context) => getIt()),
        ChangeNotifierProvider<SettingsProvider>(create: (context) => getIt()),
      ],
      child: Builder(builder: (context) {
        final onboardingComplete = context.select<SettingsProvider, bool>(
          (settings) => settings.preference.onboardingComplete,
        );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          title: AppStrings.kTitle,
          home: onboardingComplete ? const AppPage() : const OnboardingPage(),
        );
      }),
    );
  }
}
