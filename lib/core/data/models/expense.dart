import 'package:hive/hive.dart';
import 'package:expense_bud/core/domain/entities/expense.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String createdAt;

  @HiveField(1)
  final String updatedAt;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final String transactionType;

  TransactionModel({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
    required this.transactionType,
  });

  @override
  String toString() {
    return 'TransactionModel(createdAt: $createdAt, updatedAt: $updatedAt, category: $category, amount: $amount, transactionType: $transactionType)';
  }
}
