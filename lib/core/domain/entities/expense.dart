import 'package:expense_bud/core/utils/category_items.dart';

class ExpenseEntity {
  final String createdAt;
  final String updatedAt;
  final ExpenseCategory category;
  final int amount;

  ExpenseEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
  });

  @override
  String toString() {
    return 'ExpenseEntity(createdAt: $createdAt, updatedAt: $updatedAt, category: $category, amount: $amount)';
  }
}
