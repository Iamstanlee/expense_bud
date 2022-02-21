import 'package:expense_bud/features/settings/domain/entities/currency.dart';

enum InboxAmount { today, week, month }

class UserPreferenceEntity {
  final bool showEntryDate;
  final InboxAmount inboxAmount;
  final CurrencyEntity currency;
  final bool onboardingComplete;

  UserPreferenceEntity({
    required this.showEntryDate,
    required this.inboxAmount,
    required this.currency,
    required this.onboardingComplete,
  });

  UserPreferenceEntity copyWith({
    bool? showEntryDate,
    InboxAmount? inboxAmount,
    CurrencyEntity? currency,
    bool? onboardingComplete,
  }) {
    return UserPreferenceEntity(
      showEntryDate: showEntryDate ?? this.showEntryDate,
      inboxAmount: inboxAmount ?? this.inboxAmount,
      currency: currency ?? this.currency,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  @override
  String toString() {
    return 'UserPreferenceEntity(showEntryDate: $showEntryDate, inboxAmount: $inboxAmount, currency: $currency, onboardingComplete: $onboardingComplete)';
  }
}
