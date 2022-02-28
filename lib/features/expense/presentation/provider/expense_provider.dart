import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/utils/async_value.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/features/expense/domain/usecases/create_entry_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/erase_entries_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/get_expenses_usecase.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  ExpenseProvider({
    required GetExpensesUsecase getExpensesUsecase,
    required CreateExpenseEntryUsecase createExpenseEntryUsecase,
    required EraseEntriesUsecase eraseEntriesUsecase,
  })  : _getExpensesUsecase = getExpensesUsecase,
        _createExpenseEntryUsecase = createExpenseEntryUsecase,
        _eraseEntriesUsecase = eraseEntriesUsecase;

  final GetExpensesUsecase _getExpensesUsecase;
  final CreateExpenseEntryUsecase _createExpenseEntryUsecase;
  final EraseEntriesUsecase _eraseEntriesUsecase;

  final DateFormatter dateFmt = DateFormatter.instance;
  AsyncValue<Map<String, List<ExpenseEntity>>> _entries = AsyncValue.loading();
  AsyncValue<Map<String, List<ExpenseEntity>>> get entries => _entries;

  String get currentDateString => dateFmt.datetimeToString(DateTime.now());
  String get currentDateKey =>
      DateFormatter(kDay).stringToKey(DateTime.now().toIso8601String());

  String getReadableDateString(String key) =>
      dateFmt.datetimeToString(key.toDateTime());

  void getEntries() {
    _getExpensesUsecase().listen((failureOrEntries) {
      failureOrEntries.fold(
        (failure) => _entries = AsyncValue.error(_handleFailure(failure)),
        (data) => _entries = AsyncValue.done(data),
      );
      notifyListeners();
    });
  }

  Future<void> createExpenseEntry(ExpenseEntity entry) async {
    final failureOrEntry = await _createExpenseEntryUsecase(entry);
    failureOrEntry.fold((failure) => _handleFailure(failure), (_) {});
  }

  Future<void> eraseEntries() async {
    final failureOrSuccess = await _eraseEntriesUsecase();
    failureOrSuccess.fold((failure) => _handleFailure(failure), (_) {
      _entries = AsyncValue.done({});
    });
    notifyListeners();
  }

  int getDailyTotal([List<ExpenseEntity>? entries]) {
    if (entries != null) {
      return _getTotal(entries);
    }
    if (_entries.data != null) {
      return _getTotal(_entries.data![currentDateKey]);
    }
    return 0;
  }

  int getWeeklyTotal() {
    final thisWeek = dateFmt.getWeekOfMonth(DateTime.now());
    return _entries.data?.keys.fold<int>(
          0,
          (acc, key) {
            // complete week from previous month if [thisWeek] is the first week of the month?
            final entryWeek = dateFmt.getWeekOfMonth(key.toDateTime());
            if (thisWeek == entryWeek) {
              acc += _getTotal(_entries.data![key]);
            }
            return acc;
          },
        ) ??
        0;
  }

  int getMonthlyTotal() =>
      _entries.data?.values.fold<int>(
        0,
        (acc, entries) => acc += _getTotal(entries),
      ) ??
      0;

  int _getTotal(List<ExpenseEntity>? entries) {
    if (entries != null && entries.isNotEmpty) {
      return entries.fold(0, (sum, entry) => sum + entry.amount);
    }
    return 0;
  }

  String _handleFailure(Failure failure) {
    switch (failure.runtimeType) {
      case CacheGetFailure:
        return "Error getting entries from device";
      case CachePutFailure:
        return "Error saving entry to device";
      default:
        return "An unexpected error occured";
    }
  }
}
