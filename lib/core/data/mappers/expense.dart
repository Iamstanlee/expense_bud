import 'package:expense_bud/core/data/models/expense.dart';
import 'package:expense_bud/core/utils/category_items.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';

extension TransactionModelExtension on TransactionModel {
  TransactionEntity toEntity() => TransactionEntity(
        createdAt: createdAt,
        updatedAt: updatedAt,
        amount: amount,
        category: ExpenseCategory.values.singleWhere((e) => e.name == category),
        transactionType: TransactionType.values.firstWhere(
          (e) => e.name == transactionType,
          orElse: () => TransactionType.expense,
        ),
      );
}

extension TransactionEntityExtension on TransactionEntity {
  TransactionModel toModel() => TransactionModel(
        createdAt: createdAt,
        updatedAt: updatedAt,
        amount: amount,
        category: category.name,
        transactionType: transactionType.name,
      );
}
