import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/features/expense/data/datasources/local_datasource.dart';
import 'package:expense_bud/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:expense_bud/features/expense/domain/repositories/expense_repository.dart';
import 'package:expense_bud/features/expense/domain/usecases/create_entry_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/erase_entries_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/get_expenses_usecase.dart';
import 'package:expense_bud/features/expense/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/insights/data/datasources/local_datasource.dart';
import 'package:expense_bud/features/insights/data/repositories/insight_repository_impl.dart';
import 'package:expense_bud/features/insights/domain/repositories/insight_repository.dart';
import 'package:expense_bud/features/insights/domain/usecases/get_insights_usecase.dart';
import 'package:expense_bud/features/insights/presentation/provider/insights_provider.dart';
import 'package:expense_bud/features/settings/data/datasources/user_preference_local_datasource.dart';
import 'package:expense_bud/features/settings/data/models/currency.dart';
import 'package:expense_bud/features/settings/data/models/user_preference.dart';
import 'package:expense_bud/features/settings/data/user_preference_repository_impl.dart';
import 'package:expense_bud/features/settings/domain/repositories/user_preference_repository.dart';
import 'package:expense_bud/features/settings/domain/usecases/get_user_preference_usecase.dart';
import 'package:expense_bud/features/settings/domain/usecases/update_user_preference_usecase.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.I;

Future<void> initApp() async {
  Hive.initFlutter();
  Hive.registerAdapter<ExpenseModel>(ExpenseModelAdapter());
  Hive.registerAdapter<UserPreferenceModel>(UserPreferenceModelAdapter());
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());

  final _expenseDb = await Hive.openBox("expenses.db");
  final _preferenceDb = await Hive.openBox("preferences.db");

  /// datasources
  getIt.registerSingleton<IExpenseLocalDataSource>(
      ExpenseLocalDataSource(_expenseDb));
  getIt.registerSingleton<IInsightLocalDataSource>(
      InsightLocalDataSource(_expenseDb));
  getIt.registerSingleton<IUserPreferenceLocalDataSource>(
      UserPreferenceLocalDataSource(_preferenceDb));

  /// repositories
  getIt.registerSingleton<IExpenseRepository>(ExpenseRepository(getIt()));
  getIt.registerSingleton<IInsightRepository>(InsightRepository(getIt()));
  getIt.registerSingleton<IUserPreferenceRepository>(
      UserPreferenceRepository(getIt()));

  /// usecases
  getIt.registerSingleton<GetExpensesUsecase>(GetExpensesUsecase(getIt()));
  getIt.registerSingleton<CreateExpenseEntryUsecase>(
      CreateExpenseEntryUsecase(getIt()));
  getIt.registerSingleton<EraseEntriesUsecase>(EraseEntriesUsecase(getIt()));
  getIt.registerSingleton<GetUserPreferenceUsecase>(
      GetUserPreferenceUsecase(getIt()));
  getIt.registerSingleton<UpdateUserPreferenceUsecase>(
      UpdateUserPreferenceUsecase(getIt()));
  getIt.registerSingleton<GetInsightsUsecase>(GetInsightsUsecase(getIt()));

  /// providers
  getIt.registerSingleton<SettingsProvider>(
    SettingsProvider(
      getUserPreferenceUsecase: getIt(),
      updateUserPreferenceUsecase: getIt(),
    )..getUserPref(),
  );

  getIt.registerSingleton<ExpenseProvider>(
    ExpenseProvider(
      getExpensesUsecase: getIt(),
      createExpenseEntryUsecase: getIt(),
      eraseEntriesUsecase: getIt(),
    ),
  );
  getIt.registerSingleton<InsightsProvider>(
    InsightsProvider(
      getInsightsUsecase: getIt(),
    ),
  );
}
