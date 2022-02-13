import 'package:expense_bud/core/utils/device.dart';
import 'package:expense_bud/features/app/data/preference_repository.dart';
import 'package:expense_bud/features/app/presentation/providers/preference_provider.dart';
import 'package:expense_bud/features/expenses/data/datasources/local_datasource.dart';
import 'package:expense_bud/features/expenses/data/models/expense.dart';
import 'package:expense_bud/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:expense_bud/features/expenses/domain/repositories/expense_repository.dart';
import 'package:expense_bud/features/expenses/domain/usecases/create_entry_usecase.dart';
import 'package:expense_bud/features/expenses/domain/usecases/erase_entries_usecase.dart';
import 'package:expense_bud/features/expenses/domain/usecases/get_all_expenses_usecase.dart';
import 'package:expense_bud/features/expenses/domain/usecases/get_expenses_usecase.dart';
import 'package:expense_bud/features/expenses/presentation/provider/expense_provider.dart';
import 'package:expense_bud/features/settings/data/datasources/user_preference_local_datasource.dart';
import 'package:expense_bud/features/settings/data/models/user_preference.dart';
import 'package:expense_bud/features/settings/data/user_preference_repository_impl.dart';
import 'package:expense_bud/features/settings/domain/repositories/user_preference_repository.dart';
import 'package:expense_bud/features/settings/domain/usecases/get_user_preference_usecase.dart';
import 'package:expense_bud/features/settings/domain/usecases/update_user_preference_usecase.dart';
import 'package:expense_bud/features/settings/presentation/providers/settings_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.I;

Future<void> initApp() async {
  final storage = await getStorageDirectory();
  Hive.init(storage);
  Hive.registerAdapter<ExpenseModel>(ExpenseModelAdapter());
  Hive.registerAdapter<UserPreferenceModel>(UserPreferenceModelAdapter());

  final _expenseDb = await Hive.openBox("expenses.db");
  final _preferenceDb = await Hive.openBox("preferences.db");

  /// datasources
  getIt.registerSingleton<IExpenseLocalDataSource>(
      ExpenseLocalDataSource(_expenseDb));
  getIt.registerSingleton<IUserPreferenceLocalDataSource>(
      UserPreferenceLocalDataSource(_preferenceDb));

  /// repositories
  getIt.registerSingleton<IPreferenceRepository>(
      PreferenceRepository(_preferenceDb));
  getIt.registerSingleton<IExpenseRepository>(ExpenseRepository(getIt()));
  getIt.registerSingleton<IUserPreferenceRepository>(
      UserPreferenceRepository(getIt()));

  /// usecases
  getIt.registerSingleton<GetExpensesUsecase>(GetExpensesUsecase(getIt()));
  getIt.registerSingleton<CreateExpenseEntryUsecase>(
      CreateExpenseEntryUsecase(getIt()));
  getIt
      .registerSingleton<GetAllExpensesUsecase>(GetAllExpensesUsecase(getIt()));
  getIt
      .registerSingleton<EraseEntriesUsecase>(EraseEntriesUsecase(getIt()));
  getIt.registerSingleton<GetUserPreferenceUsecase>(
      GetUserPreferenceUsecase(getIt()));
  getIt.registerSingleton<UpdateUserPreferenceUsecase>(
      UpdateUserPreferenceUsecase(getIt()));

  /// providers
  getIt.registerSingleton<PreferenceProvider>(
    PreferenceProvider(preferenceRepository: getIt()),
  );
  getIt.registerSingleton<SettingsProvider>(
    SettingsProvider(
      getUserPreferenceUsecase: getIt(),
      updateUserPreferenceUsecase: getIt(),
    )..getUserPref(),
  );

  getIt.registerSingleton<ExpenseProvider>(
    ExpenseProvider(
      getExpensesUsecase: getIt(),
      getAllExpensesUsecase: getIt(),
      createExpenseEntryUsecase: getIt(),
      eraseEntriesUsecase: getIt(),
    ),
  );
}
