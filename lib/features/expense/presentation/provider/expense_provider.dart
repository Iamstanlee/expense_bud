import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/utils/async_value.dart';
import 'package:expense_bud/core/utils/date_formatter.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:expense_bud/features/expense/domain/entities/expense.dart';
import 'package:expense_bud/features/expense/domain/usecases/create_entry_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/erase_entries_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/get_month_expenses_usecase.dart';
import 'package:expense_bud/features/expense/domain/usecases/get_expenses_usecase.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier {
  ExpenseProvider({
    required GetMonthExpensesUsecase getMonthExpensesUsecase,
    required GetExpensesUsecase getExpensesUsecase,
    required CreateExpenseEntryUsecase createExpenseEntryUsecase,
    required EraseEntriesUsecase eraseEntriesUsecase,
  })  : _getMonthExpensesUsecase = getMonthExpensesUsecase,
        _getExpensesUsecase = getExpensesUsecase,
        _createExpenseEntryUsecase = createExpenseEntryUsecase,
        _eraseEntriesUsecase = eraseEntriesUsecase;

  final GetMonthExpensesUsecase _getMonthExpensesUsecase;
  final GetExpensesUsecase _getExpensesUsecase;
  final CreateExpenseEntryUsecase _createExpenseEntryUsecase;
  final EraseEntriesUsecase _eraseEntriesUsecase;

  final DateFormatter _dateFormatter = DateFormatter.instance;
  AsyncValue<List<ExpenseEntity>> _dayEntries = AsyncValue.loading();
  AsyncValue<List<ExpenseEntity>> get currentDayEntries => _dayEntries;

  AsyncValue<Map<String, List<ExpenseEntity>?>> _monthEntries =
      AsyncValue.loading();
  AsyncValue<Map<String, List<ExpenseEntity>?>> get allEntries => _monthEntries;

  String get currentDateString =>
      _dateFormatter.datetimeToString(DateTime.now());

  String getReadableDateString(String key) =>
      _dateFormatter.datetimeToString(key.toDateTime());

  int _getTotal(List<ExpenseEntity>? entries) {
    if (entries != null && entries.isNotEmpty) {
      return entries.fold(0, (sum, entry) => sum + entry.amount);
    }
    return 0;
  }

  int getDayTotal([List<ExpenseEntity>? entries]) =>
      _getTotal(entries ?? _dayEntries.data);

  int getWeekTotal() {
    final thisWeek = _dateFormatter.getWeekOfMonth(DateTime.now());
    return _monthEntries.data?.keys.fold<int>(
          0,
          (acc, key) {
            // complete week from previous month if [thisWeek] is the first week of the month?
            final entryWeek = _dateFormatter.getWeekOfMonth(key.toDateTime());
            if (thisWeek == entryWeek) {
              acc += _getTotal(_monthEntries.data![key]);
            }
            return acc;
          },
        ) ??
        0;
  }

  int getMonthTotal() =>
      _monthEntries.data?.values.fold<int>(
        0,
        (acc, entries) => acc += _getTotal(entries),
      ) ??
      0;

  void getDayEntries() async {
    final failureOrEntries = await _getExpensesUsecase();
    failureOrEntries.fold(
      (failure) => _dayEntries = AsyncValue.error(_handleFailure(failure)),
      (data) => _dayEntries = AsyncValue.done(data),
    );
    notifyListeners();
  }

  void getMonthEntries() async {
    final failureOrEntries = await _getMonthExpensesUsecase();
    failureOrEntries.fold(
      (failure) => _monthEntries = AsyncValue.error(_handleFailure(failure)),
      (data) {
        _monthEntries = AsyncValue.done(data);
      },
    );
    notifyListeners();
  }

  Future<void> createExpenseEntry(ExpenseEntity entry) async {
    final failureOrEntry = await _createExpenseEntryUsecase(entry);
    failureOrEntry.fold((failure) => _handleFailure(failure), (entry) {
      _dayEntries = AsyncValue.done([entry, ..._dayEntries.data!]);
      final _month = _monthEntries.data;
      if (_month != null) {
        final _fmt = DateFormatter(kDay);
        final _key = _fmt.datetimeToString(DateTime.now());
        if (_month.containsKey(_key)) {
          final _entries = [entry, ..._month[_key]!];
          _monthEntries = AsyncValue.done({
            ..._month,
            _key: _entries,
          });
        } else {
          _monthEntries = AsyncValue.done({
            ..._month,
            _key: [entry],
          });
        }
      }
    });
    notifyListeners();
  }

  Future<void> eraseEntries() async {
    final failureOrSuccess = await _eraseEntriesUsecase();
    failureOrSuccess.fold((failure) => _handleFailure(failure), (_) {
      _dayEntries = AsyncValue.done([]);
      _monthEntries = AsyncValue.done({});
    });
    notifyListeners();
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
