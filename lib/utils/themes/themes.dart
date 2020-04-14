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
    accentColor: Color(0XFF21C8F6),
    primaryColor: Color(0xFF637BFF),
    canvasColor: Color(0xFF141414),
    fontFamily: fontFamily,
  );

  static final ThemeData eveningTheme = ThemeData(
    textTheme: textTheme,
    accentColor: Color(0XFFCF5C36),
    primaryColor: Color(0XFF160F29),
    canvasColor: Color(0xFF641514),
    fontFamily: fontFamily,
  );

  static final ThemeData nightTheme = ThemeData(
    textTheme: textTheme,
    accentColor: Color(0xFF011526),
    primaryColor: Color(0xFF024873),
    canvasColor: Color(0xFF141414),
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
    return AppThemes.getThemeFromKey(getThemeKeyFromTime(_dateTime));
  }

  static AppThemeKeys getThemeKeyFromTime(DateTime locationDate) {
    int _currentHour = locationDate.hour;

    if (_currentHour >= 6 && _currentHour <= 15) {
      return AppThemeKeys.DAY;
    } else if (_currentHour >= 16 && _currentHour <= 18) {
      return AppThemeKeys.EVENING;
    } else {
      return AppThemeKeys.NIGHT;
    }
  }
}
