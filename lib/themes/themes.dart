import 'package:flutter/material.dart';

enum AppThemeKeys { DAY, EVENING, NIGHT }

class AppThemes {
  static final fontFamily = 'AvenirNextLTPro';

  static final TextTheme textTheme = TextTheme(
    title: TextStyle(color: Colors.white),
    subhead: TextStyle(color: Colors.white),
    subtitle: TextStyle(color: Colors.white),
    body1: TextStyle(color: Colors.white),
    body2: TextStyle(color: Colors.white),
  ).apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );

  static final ThemeData dayTheme = ThemeData(
    textTheme: textTheme,
    accentColor: Color(0XFF078DD9),
    primaryColor: Color(0xFF0669BF),
    fontFamily: fontFamily,
  );

  static final ThemeData eveningTheme = ThemeData(
    textTheme: textTheme,
    accentColor: Color(0XFFFE7F4A),
    primaryColor: Color(0XFF2F0F2C),
    fontFamily: fontFamily,
  );

  static final ThemeData nightTheme = ThemeData(
    textTheme: textTheme,
    accentColor: Color(0xFF010A5D),
    primaryColor: Color(0xFF010A26),
    fontFamily: fontFamily,
  );

  static ThemeData getThemeFromKey(AppThemeKeys appThemeKeys) {
    ThemeData currentTheme = ThemeData();
    switch (appThemeKeys) {
      case AppThemeKeys.DAY:
        currentTheme = dayTheme;
        break;
      case AppThemeKeys.EVENING:
        currentTheme = eveningTheme;
        break;
      case AppThemeKeys.NIGHT:
        currentTheme = nightTheme;
        break;
    }
    return currentTheme;
  }

  static ThemeData setCurrentDynamicTheme() {
    DateTime _dateTime = DateTime.now();
    _dateTime = DateTime.now();
    int _currentHour = _dateTime.hour;
    print(_currentHour);

    if (_currentHour >= 6 && _currentHour <= 15) {
      return getThemeFromKey(AppThemeKeys.DAY);
    } else if (_currentHour >= 16 && _currentHour <= 18) {
      return getThemeFromKey(AppThemeKeys.EVENING);
    } else {
      return getThemeFromKey(AppThemeKeys.NIGHT);
    }
  }
}
