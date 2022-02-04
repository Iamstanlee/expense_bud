import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:expense_tracker/features/expenses/domain/entities/expense.dart';

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
    iconData: PhosphorIcons.bag,
  ),
  ExpenseCategoryItem(
    title: 'Food & Drinks',
    category: ExpenseCategory.foodAndDrinks,
    iconData: PhosphorIcons.cookingPot,
  ),
  ExpenseCategoryItem(
    title: 'Coffee',
    category: ExpenseCategory.coffee,
    iconData: PhosphorIcons.coffee,
  ),
  ExpenseCategoryItem(
    title: 'Subscription',
    category: ExpenseCategory.subscription,
    iconData: PhosphorIcons.calendar,
  ),
  ExpenseCategoryItem(
      title: 'Car',
      category: ExpenseCategory.car,
      iconData: PhosphorIcons.carSimple),
  ExpenseCategoryItem(
    title: 'Taxi',
    category: ExpenseCategory.taxi,
    iconData: PhosphorIcons.taxi,
  ),
  ExpenseCategoryItem(
    title: 'Clothing',
    category: ExpenseCategory.clothing,
    iconData: PhosphorIcons.tShirt,
  ),
  ExpenseCategoryItem(
    title: 'Travel',
    category: ExpenseCategory.travel,
    iconData: PhosphorIcons.airplaneTilt,
  ),
  ExpenseCategoryItem(
    title: 'Snacks',
    category: ExpenseCategory.snacks,
    iconData: PhosphorIcons.pizza,
  ),
  ExpenseCategoryItem(
    title: 'Pet',
    category: ExpenseCategory.pet,
    iconData: PhosphorIcons.cat,
  ),
  ExpenseCategoryItem(
    title: 'Tech',
    category: ExpenseCategory.tech,
    iconData: PhosphorIcons.deviceMobileCamera,
  ),
  ExpenseCategoryItem(
    title: 'Business',
    category: ExpenseCategory.business,
    iconData: PhosphorIcons.briefcase,
  ),
  ExpenseCategoryItem(
    title: 'Home',
    category: ExpenseCategory.home,
    iconData: PhosphorIcons.house,
  ),
  ExpenseCategoryItem(
    title: 'Health',
    category: ExpenseCategory.health,
    iconData: PhosphorIcons.heartbeat,
  ),
  ExpenseCategoryItem(
    title: 'Gifts',
    category: ExpenseCategory.gifts,
    iconData: PhosphorIcons.gift,
  ),
  ExpenseCategoryItem(
    title: 'Miscellaneous',
    category: ExpenseCategory.miscellaneous,
    iconData: PhosphorIcons.asterisk,
  ),
];
