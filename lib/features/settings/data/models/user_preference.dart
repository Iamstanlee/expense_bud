import 'package:expense_bud/features/settings/data/models/currency.dart';
import 'package:hive/hive.dart';

part 'user_preference.g.dart';

@HiveType(typeId: 1)
class UserPreferenceModel extends HiveObject {
  @HiveField(0)
  final bool showEntryDate;

  @HiveField(1)
  final String inboxAmount;

  @HiveField(2)
  final CurrencyModel currency;

  @HiveField(3)
  final bool onboardingComplete;

  @HiveField(4, defaultValue: false)
  final bool showCharts;

  UserPreferenceModel({
    required this.showEntryDate,
    required this.inboxAmount,
    required this.currency,
    required this.onboardingComplete,
    required this.showCharts,
  });
}
