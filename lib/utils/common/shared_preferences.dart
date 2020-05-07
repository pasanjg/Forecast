import 'package:shared_preferences/shared_preferences.dart';

/// Code referred from pub.dev
/// See <https://pub.dev/packages/shared_preferences> for source.
class AppSharedPreferences {
  static setStringSharedPreferences(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static Future<String> getStringSharedPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}
