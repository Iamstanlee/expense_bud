import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/failure/failure.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';

abstract class IExpenseRepository {
  Future<Either<Failure, List<ExpenseEntity>>> getCurrentDayExpenseEntries();
  Future<Either<Failure, Map<String, List<ExpenseEntity>>>>
      getAllExpenseEntries();
  Future<Either<Failure, ExpenseEntity>> createExpenseEntry(
    ExpenseEntity expense,
  );
}
