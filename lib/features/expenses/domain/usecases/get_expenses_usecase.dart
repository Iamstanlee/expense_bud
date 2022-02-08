import 'package:dartz/dartz.dart';

import 'package:expense_tracker/core/failure/failure.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/features/expenses/domain/repositories/expense_repository.dart';

class GetExpensesUsecase
    implements NoArgsUsecase<List<ExpenseEntity>> {
  final IExpenseRepository _expenseRepository;
  GetExpensesUsecase(this._expenseRepository);

  @override
  Future<Either<Failure, List<ExpenseEntity>>> call() {
    return _expenseRepository.getCurrentDayExpenseEntries();
  }
}
