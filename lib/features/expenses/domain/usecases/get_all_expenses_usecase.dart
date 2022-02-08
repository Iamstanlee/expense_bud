import 'package:dartz/dartz.dart';

import 'package:expense_tracker/core/failure/failure.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/features/expenses/domain/repositories/expense_repository.dart';

class GetAllExpensesUsecase
    implements NoArgsUsecase<Map<String, List<ExpenseEntity>>> {
  final IExpenseRepository _expenseRepository;
  GetAllExpensesUsecase(this._expenseRepository);

  @override
  Future<Either<Failure, Map<String, List<ExpenseEntity>>>> call() {
    return _expenseRepository.getAllExpenseEntries();
  }
}
