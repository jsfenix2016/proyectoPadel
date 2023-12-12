import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUser {
  static final PreferenceUser _instance = PreferenceUser._internal();
  factory PreferenceUser() {
    return _instance;
  }
  PreferenceUser._internal();
  // ignore: prefer_typing_uninitialized_variables
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get onBoarding {
    return _prefs.getBool('onboard') ?? false;
  }

  set onboarding(bool value) {
    _prefs.setBool('onboard', value);
  }

  get getUrlTemp {
    return _prefs.getString('urlTemp') ?? "";
  }

  set setUrlTemp(String value) {
    _prefs.setString('urlTemp', value);
  }

  get getFCM {
    return _prefs.getString('fcm') ?? "";
  }

  set setFCM(String value) {
    _prefs.setString('fcm', value);
  }
}
