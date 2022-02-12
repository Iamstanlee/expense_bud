import 'package:expense_bud/features/settings/data/models/user_preference.dart';
import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';

extension UserPreferenceEntityMapper on UserPreferenceEntity {
  UserPreferenceModel toModel() => UserPreferenceModel(
        showEntryDate: showEntryDate,
        inboxAmount: inboxAmount.name,
      );
}

extension UserPreferenceModelMapper on UserPreferenceModel {
  UserPreferenceEntity toEntity() => UserPreferenceEntity(
        showEntryDate: showEntryDate,
        inboxAmount:
            InboxAmount.values.singleWhere((e) => e.name == inboxAmount),
      );
}
