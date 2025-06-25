import 'package:dartz/dartz.dart';

import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/domain/usecases/usecase.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';
import 'package:expense_bud/features/expense/domain/repositories/expense_repository.dart';

class CreateExpenseEntryUsecase
    implements UsecaseOfFuture<Unit, TransactionEntity> {
  final IExpenseRepository _repository;

  CreateExpenseEntryUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(TransactionEntity params) {
    return _repository.createExpenseEntry(params);
  }
}
