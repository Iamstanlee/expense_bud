import 'package:expense_bud/features/settings/domain/entities/user_preference.dart';
import 'package:expense_bud/features/settings/domain/usecases/get_user_preference_usecase.dart';
import 'package:expense_bud/features/settings/domain/usecases/update_user_preference_usecase.dart';
import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider({
    required GetUserPreferenceUsecase getUserPreferenceUsecase,
    required UpdateUserPreferenceUsecase updateUserPreferenceUsecase,
  })  : _getUserPreferenceUsecase = getUserPreferenceUsecase,
        _updateUserPreferenceUsecase = updateUserPreferenceUsecase;

  final GetUserPreferenceUsecase _getUserPreferenceUsecase;
  final UpdateUserPreferenceUsecase _updateUserPreferenceUsecase;

  UserPreferenceEntity _preference = UserPreferenceEntity(
    inboxAmount: InboxAmount.week,
    showEntryDate: false,
  );

  UserPreferenceEntity get preference => _preference;
  set __preference(UserPreferenceEntity pref) {
    _preference = pref;
    notifyListeners();
  }

  Future<void> updateUserPref(UserPreferenceEntity pref) async {
    final failureOrSuccess = await _updateUserPreferenceUsecase(pref);
    failureOrSuccess.fold((failure) {}, (_) => __preference = pref);
  }

  Future<void> getUserPref() async {
    final failureOrSuccess = await _getUserPreferenceUsecase();
    failureOrSuccess.fold((failure) {}, (pref) {
      if (pref != null) __preference = pref;
    });
  }
}
