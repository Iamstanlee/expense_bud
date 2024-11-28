import 'package:expense_bud/core/failure/exceptions.dart';
import 'package:expense_bud/features/settings/data/models/user_preference.dart';
import 'package:hive/hive.dart';

abstract class IUserPreferenceLocalDataSource {
  Future<UserPreferenceModel?> getUserPreference();

  Future<void> updateUserPreference(UserPreferenceModel preference);
}

const _userPrefsKey = 'userPrefs';

class UserPreferenceLocalDataSource implements IUserPreferenceLocalDataSource {
  final Box _box;

  UserPreferenceLocalDataSource(this._box);

  @override
  Future<UserPreferenceModel?> getUserPreference() async {
    try {
      return _box.get(_userPrefsKey) as UserPreferenceModel?;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateUserPreference(UserPreferenceModel pref) async {
    try {
      await _box.put(_userPrefsKey, pref);
    } catch (e) {
      throw CacheException();
    }
  }
}
