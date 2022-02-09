import 'package:expense_bud/features/app/data/preference_repository.dart';
import 'package:flutter/material.dart';

class PreferenceProvider with ChangeNotifier {
  final IPreferenceRepository _preferenceRepository;
  PreferenceProvider({required IPreferenceRepository preferenceRepository})
      : _preferenceRepository = preferenceRepository;

  bool get onboardingFinished => _preferenceRepository.onboardingFinished;
  void completeOnboarding() => _preferenceRepository.onboardingFinished = true;
}
