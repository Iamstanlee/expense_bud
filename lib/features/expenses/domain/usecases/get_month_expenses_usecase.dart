import 'package:dartz/dartz.dart';

import 'package:expense_bud/core/failure/failure.dart';
import 'package:expense_bud/core/usecases/usecase.dart';
import 'package:expense_bud/features/expenses/domain/entities/expense.dart';
import 'package:expense_bud/features/expenses/domain/repositories/expense_repository.dart';

class GetMonthExpensesUsecase
    implements NoArgsUsecase<Map<String, List<ExpenseEntity>>> {
  final IExpenseRepository _expenseRepository;
  GetMonthExpensesUsecase(this._expenseRepository);

  @override
  Future<Either<Failure, Map<String, List<ExpenseEntity>>>> call() {
    return _expenseRepository.getCurrentMonthEntries();
  }
}
