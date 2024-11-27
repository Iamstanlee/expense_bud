import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
  final Color color;
  const ExpenseCategoryItem({
    required this.title,
    required this.category,
    required this.iconData,
    this.color = Colors.grey,
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

List<ExpenseCategoryItem> categoryItems() => const [
      ExpenseCategoryItem(
        title: 'Groceries',
        category: ExpenseCategory.groceries,
        iconData: PhosphorIconsFill.basket,
        color: Color(0xFFF8C795),
      ),
      ExpenseCategoryItem(
        title: 'Food & Drinks',
        category: ExpenseCategory.foodAndDrinks,
        iconData: PhosphorIconsFill.avocado,
        color: Color(0xFF71B3FC),
      ),
      ExpenseCategoryItem(
        title: 'Coffee',
        category: ExpenseCategory.coffee,
        iconData: PhosphorIconsFill.coffee,
        color: Color(0xFF567FFB),
      ),
      ExpenseCategoryItem(
        title: 'Subscription',
        category: ExpenseCategory.subscription,
        iconData: PhosphorIconsFill.calendar,
        color: Color(0xFF84E9C7),
      ),
      ExpenseCategoryItem(
        title: 'Car',
        category: ExpenseCategory.car,
        iconData: PhosphorIconsFill.carProfile,
        color: Color(0xFFEF80A2),
      ),
      ExpenseCategoryItem(
        title: 'Taxi',
        category: ExpenseCategory.taxi,
        iconData: PhosphorIconsFill.taxi,
        color: Color(0xFFF5B5B6),
      ),
      ExpenseCategoryItem(
        title: 'Clothing',
        category: ExpenseCategory.clothing,
        iconData: PhosphorIconsFill.tShirt,
        color: Color(0xFFF8BA58),
      ),
      ExpenseCategoryItem(
        title: 'Travel',
        category: ExpenseCategory.travel,
        iconData: PhosphorIconsFill.airplaneTilt,
        color: Color(0xFFCDDD36),
      ),
      ExpenseCategoryItem(
        title: 'Snacks',
        category: ExpenseCategory.snacks,
        color: Color(0xFFDD3636),
        iconData: PhosphorIconsFill.bread,
      ),
      ExpenseCategoryItem(
        title: 'Pet',
        category: ExpenseCategory.pet,
        iconData: PhosphorIconsFill.dog,
        color: Color(0xFFDD9736),
      ),
      ExpenseCategoryItem(
        title: 'Tech',
        category: ExpenseCategory.tech,
        iconData: PhosphorIconsFill.deviceMobileCamera,
        color: Color(0xFFDDCD36),
      ),
      ExpenseCategoryItem(
        title: 'Business',
        category: ExpenseCategory.business,
        iconData: PhosphorIconsFill.briefcase,
        color: Color(0xFF93DD36),
      ),
      ExpenseCategoryItem(
        title: 'Home',
        category: ExpenseCategory.home,
        iconData: PhosphorIconsFill.house,
        color: Color(0xFF36CADD),
      ),
      ExpenseCategoryItem(
        title: 'Health',
        category: ExpenseCategory.health,
        iconData: PhosphorIconsFill.heartbeat,
        color: Color(0xFF36B5DD),
      ),
      ExpenseCategoryItem(
        title: 'Gifts',
        category: ExpenseCategory.gifts,
        iconData: PhosphorIconsFill.gift,
        color: Color(0xFF366CDD),
      ),
      ExpenseCategoryItem(
        title: 'Miscellaneous',
        category: ExpenseCategory.miscellaneous,
        iconData: PhosphorIconsFill.asterisk,
        color: Color(0xFF9A36DD),
      ),
    ];
