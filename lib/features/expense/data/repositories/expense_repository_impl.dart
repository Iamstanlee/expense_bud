import 'package:expense_bud/features/expense/data/datasources/local_datasource.dart';
import 'package:expense_bud/features/expense/domain/entities/expense.dart';
import 'package:expense_bud/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:expense_bud/features/expense/domain/repositories/expense_repository.dart';
import 'package:expense_bud/features/expense/data/mappers/expense.dart';

class ExpenseRepository implements IExpenseRepository {
  final IExpenseLocalDataSource _localDataSource;
  ExpenseRepository(this._localDataSource);

  @override
  Future<Either<Failure, ExpenseEntity>> createExpenseEntry(
      ExpenseEntity expense) async {
    try {
      final _expense =
          await _localDataSource.createExpenseEntry(expense.toModel());
      return Right(_expense.toEntity());
    } catch (e) {
      return Left(CachePutFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, List<ExpenseEntity>>>>
      getMonthlyEntries() async {
    try {
      final _entries = await _localDataSource.getMonthlyEntries();
      return Right(
        _entries.map(
          (key, value) => MapEntry(
            key,
            value.map((e) => e.toEntity()).toList(),
          ),
        ),
      );
    } catch (e) {
      return Left(CacheGetFailure());
    }
  }

  @override
  Future<Either<Failure, List<ExpenseEntity>>> getDailyEntries() async {
    try {
      final _entries = await _localDataSource.getDailyEntries();
      return Right(_entries.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(CacheGetFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> eraseEntries() async {
    try {
      await _localDataSource.eraseEntries();
      return const Right(unit);
    } catch (e) {
      return Left(CacheGetFailure());
    }
  }
}
