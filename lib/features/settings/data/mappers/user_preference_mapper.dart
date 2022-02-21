import 'package:expense_bud/features/settings/data/mappers/currency_mapper.dart';
import 'package:expense_bud/features/settings/data/models/user_preference.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';

extension UserPreferenceEntityMapper on UserPreferenceEntity {
  UserPreferenceModel toModel() => UserPreferenceModel(
        showEntryDate: showEntryDate,
        inboxAmount: inboxAmount.name,
        currency: currency.toModel(),
        onboardingComplete: onboardingComplete,
      );
}

extension UserPreferenceModelMapper on UserPreferenceModel {
  UserPreferenceEntity toEntity() => UserPreferenceEntity(
        showEntryDate: showEntryDate,
        inboxAmount:
            InboxAmount.values.singleWhere((e) => e.name == inboxAmount),
        currency: currency.toEntity(),
        onboardingComplete: onboardingComplete,
      );
}
