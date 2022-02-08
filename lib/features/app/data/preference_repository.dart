import 'package:hive/hive.dart';

abstract class IPreferenceRepository {
  bool get onboardingFinished;
  set onboardingFinished(bool value);
}

const kOnboardingkey = "kOnboardingkey";

class PreferenceRepository implements IPreferenceRepository {
  final Box _box;
  PreferenceRepository(this._box);
  @override
  bool get onboardingFinished =>
      _box.get(kOnboardingkey, defaultValue: false) as bool;

  @override
  set onboardingFinished(bool value) => _box.put(kOnboardingkey, value);
}
