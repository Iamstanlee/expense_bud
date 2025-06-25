import 'package:expense_bud/core/utils/category_items.dart';

class ExpenseEntity {
  final String createdAt;
  final String updatedAt;
  final ExpenseCategory category;
  final int amount;
  final String? note;

  ExpenseEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
    this.note,
  });

  @override
  String toString() {
    return 'ExpenseEntity(createdAt: $createdAt, updatedAt: $updatedAt, category: $category, amount: $amount, note: $note)';
  }
}
