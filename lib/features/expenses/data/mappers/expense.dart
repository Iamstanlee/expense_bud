import 'package:expense_tracker/features/expenses/data/models/expense.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';
import 'package:flutter/foundation.dart';

extension ExpenseModelExtension on ExpenseModel {
  ExpenseEntity toEntity() => ExpenseEntity(
        createdAt: createdAt,
        updatedAt: updatedAt,
        amount: amount,
        category: ExpenseCategory.values
            .singleWhere((e) => describeEnum(e) == category),
      );
}

extension ExpenseEntityExtension on ExpenseEntity {
  ExpenseModel toModel() => ExpenseModel(
        createdAt: createdAt,
        updatedAt: updatedAt,
        amount: amount,
        category: describeEnum(category),
      );
}
