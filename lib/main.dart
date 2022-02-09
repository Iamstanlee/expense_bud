import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/features/app/presentation/app.dart';
import 'package:expense_bud/features/app/presentation/onboarding.dart';
import 'package:expense_bud/features/app/presentation/providers/preference_provider.dart';
import 'package:expense_bud/features/expenses/presentation/provider/expense_provider.dart';
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
        ChangeNotifierProvider<PreferenceProvider>(
            create: (context) => getIt()),
        ChangeNotifierProvider<ExpenseProvider>(create: (context) => getIt()),
      ],
      child: Builder(builder: (context) {
        final onboardingFinished =
            context.watch<PreferenceProvider>().onboardingFinished;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.defaultTheme,
          title: AppStrings.kTitle,
          home: onboardingFinished ? const AppPage() : const OnboardingPage(),
        );
      }),
    );
  }
}
