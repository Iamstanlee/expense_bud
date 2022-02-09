import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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

class ExpenseCategoryItem {
  final String title;
  final ExpenseCategory category;
  final IconData iconData;
  const ExpenseCategoryItem({
    required this.title,
    required this.category,
    required this.iconData,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseCategoryItem &&
        other.title == title &&
        other.category == category &&
        other.iconData == iconData;
  }

  @override
  int get hashCode => title.hashCode ^ category.hashCode ^ iconData.hashCode;
}

const List<ExpenseCategoryItem> kExpenseCategoryItems = [
  ExpenseCategoryItem(
    title: 'Groceries',
    category: ExpenseCategory.groceries,
    iconData: PhosphorIcons.bagLight,
  ),
  ExpenseCategoryItem(
    title: 'Food & Drinks',
    category: ExpenseCategory.foodAndDrinks,
    iconData: PhosphorIcons.cookingPotLight,
  ),
  ExpenseCategoryItem(
    title: 'Coffee',
    category: ExpenseCategory.coffee,
    iconData: PhosphorIcons.coffeeLight,
  ),
  ExpenseCategoryItem(
    title: 'Subscription',
    category: ExpenseCategory.subscription,
    iconData: PhosphorIcons.calendarLight,
  ),
  ExpenseCategoryItem(
    title: 'Car',
    category: ExpenseCategory.car,
    iconData: PhosphorIcons.carSimpleLight,
  ),
  ExpenseCategoryItem(
    title: 'Taxi',
    category: ExpenseCategory.taxi,
    iconData: PhosphorIcons.taxiLight,
  ),
  ExpenseCategoryItem(
    title: 'Clothing',
    category: ExpenseCategory.clothing,
    iconData: PhosphorIcons.tShirtLight,
  ),
  ExpenseCategoryItem(
    title: 'Travel',
    category: ExpenseCategory.travel,
    iconData: PhosphorIcons.airplaneTiltLight,
  ),
  ExpenseCategoryItem(
    title: 'Snacks',
    category: ExpenseCategory.snacks,
    iconData: PhosphorIcons.pizzaLight,
  ),
  ExpenseCategoryItem(
    title: 'Pet',
    category: ExpenseCategory.pet,
    iconData: PhosphorIcons.catLight,
  ),
  ExpenseCategoryItem(
    title: 'Tech',
    category: ExpenseCategory.tech,
    iconData: PhosphorIcons.deviceMobileCameraLight,
  ),
  ExpenseCategoryItem(
    title: 'Business',
    category: ExpenseCategory.business,
    iconData: PhosphorIcons.briefcaseLight,
  ),
  ExpenseCategoryItem(
    title: 'Home',
    category: ExpenseCategory.home,
    iconData: PhosphorIcons.houseLight,
  ),
  ExpenseCategoryItem(
    title: 'Health',
    category: ExpenseCategory.health,
    iconData: PhosphorIcons.heartbeatLight,
  ),
  ExpenseCategoryItem(
    title: 'Gifts',
    category: ExpenseCategory.gifts,
    iconData: PhosphorIcons.giftLight,
  ),
  ExpenseCategoryItem(
    title: 'Miscellaneous',
    category: ExpenseCategory.miscellaneous,
    iconData: PhosphorIcons.asteriskLight,
  ),
];
