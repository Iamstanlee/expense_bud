enum ExpenseCategory {
  foodAndDrinks,
  groceries,
  tech,
  car,
  home,
  snacks,
  subscription,
  coffee,
  clothing,
  gifts,
  taxi,
  charity,
  health,
  travel,
  business,
  pet,
  miscellaneous,
}

class ExpenseEntity {
  final String createdAt;
  final String updatedAt;
  final ExpenseCategory category;
  final double amount;

  ExpenseEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.amount,
  });
}
