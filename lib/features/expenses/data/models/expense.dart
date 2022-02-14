import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String createdAt;

  @HiveField(1)
  final String updatedAt;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final double amount;

  ExpenseModel({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
  });

  @override
  String toString() {
    return 'ExpenseModel(createdAt: $createdAt, updatedAt: $updatedAt, category: $category, amount: $amount)';
  }
}
