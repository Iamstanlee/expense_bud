import 'package:dartz/dartz.dart';

import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/domain/usecases/usecase.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/features/expense/domain/repositories/expense_repository.dart';

class CreateExpenseEntryUsecase
    implements UsecaseOfFuture<Unit, ExpenseEntity> {
  final IExpenseRepository _expenseRepository;
  CreateExpenseEntryUsecase(this._expenseRepository);

  @override
  Future<Either<Failure, Unit>> call(ExpenseEntity param) {
    return _expenseRepository.createExpenseEntry(param);
  }
}
