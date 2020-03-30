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
    primaryColor: Color(0xFF0669BF),
    accentColor: Color(0XFF078DD9),
    fontFamily: fontFamily,
  );

  static final ThemeData eveningTheme = ThemeData(
    textTheme: textTheme,
    primaryColor: Color(0XFF2D102C),
    accentColor: Color(0XFFE26340),
    fontFamily: fontFamily,
  );

  static final ThemeData nightTheme = ThemeData(
    textTheme: textTheme,
    primaryColor: Color(0xFF010A26),
    accentColor: Color(0xFF010A5D),
    fontFamily: fontFamily,
  );

  static ThemeData getThemeFromKey(AppThemeKeys forecastThemeKeys) {
    ThemeData currentTheme = ThemeData();
    switch (forecastThemeKeys) {
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
}
