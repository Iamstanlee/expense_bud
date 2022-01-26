import 'exports.dart';

void main() {
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.defaultTheme,
        title: AppStrings.kTitle,
        home: const OnboardingPage(),
      ),
    );
  }
}
