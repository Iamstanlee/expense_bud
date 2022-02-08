import 'package:dartz/dartz.dart';

import 'package:expense_tracker/core/failure/failure.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';
import 'package:expense_tracker/features/expenses/domain/repositories/expense_repository.dart';

class CreateExpenseEntryUsecase
    implements Usecase<ExpenseEntity, ExpenseEntity> {
  final IExpenseRepository _expenseRepository;
  CreateExpenseEntryUsecase(this._expenseRepository);

  @override
  Future<Either<Failure, ExpenseEntity>> call(ExpenseEntity param) {
    return _expenseRepository.createExpenseEntry(param);
  }
}
