import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static setStringSharedPreferences(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static getStringSharedPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}
