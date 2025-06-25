import 'package:dartz/dartz.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';

abstract class IExpenseRepository {
  Stream<Either<Failure, Map<String, List<TransactionEntity>>>>
      watchMonthlyEntries();
  Future<Either<Failure, Unit>> createExpenseEntry(
    TransactionEntity transaction,
  );
  Future<Either<Failure, Unit>> eraseEntries();
}
