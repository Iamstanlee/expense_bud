import 'package:expense_bud/core/utils/category_items.dart';

enum TransactionType {
  expense,
  income,
}

class TransactionEntity {
  final String createdAt;
  final String updatedAt;
  final ExpenseCategory category;
  final int amount;
  final String? note;
  final TransactionType transactionType;

  TransactionEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
    this.note,
    this.transactionType = TransactionType.expense,
  });

  @override
  String toString() {
    return 'TransactionEntity(createdAt: $createdAt, updatedAt: $updatedAt, category: $category, amount: $amount, note: $note, transactionType: $transactionType)';
  }
}
