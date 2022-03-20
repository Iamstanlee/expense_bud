import 'package:expense_bud/features/settings/domain/entities/currency.dart';

enum InboxAmount { today, week, month }

extension InboxAmountExtension on InboxAmount {
  String get title {
    switch (this) {
      case InboxAmount.today:
        return "Oggi";
      case InboxAmount.month:
        return "Questo mese";
      default:
        return "Questa settimana";
    }
  }
}

class UserPreferenceEntity {
  final bool showEntryDate;
  final bool showCharts;
  final InboxAmount inboxAmount;
  final CurrencyEntity currency;
  final bool onboardingComplete;

  UserPreferenceEntity({
    required this.showEntryDate,
    required this.showCharts,
    required this.inboxAmount,
    required this.currency,
    required this.onboardingComplete,
  });

  UserPreferenceEntity copyWith({
    bool? showEntryDate,
    bool? showCharts,
    InboxAmount? inboxAmount,
    CurrencyEntity? currency,
    bool? onboardingComplete,
  }) {
    return UserPreferenceEntity(
      showEntryDate: showEntryDate ?? this.showEntryDate,
      showCharts: showCharts ?? this.showCharts,
      inboxAmount: inboxAmount ?? this.inboxAmount,
      currency: currency ?? this.currency,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }
}
