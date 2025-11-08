import 'package:shared_preferences/shared_preferences.dart';

const _firstTimeUser = "FIRST_TIME_USER";

class PerferencesManager {

  late final SharedPreferences _prefs;

  void init(SharedPreferences pref) {
    _prefs = pref;
  }

  bool checkFirstTimeUser() {
    final isFirstTime = _prefs.getBool(_firstTimeUser) ?? true;
    return isFirstTime;
  }

  Future<void> setFirstTimeUser(bool value) async {
    await _prefs.setBool(_firstTimeUser, value);
  }
}
