import 'package:flutter/material.dart';
import 'package:forecast/utils/common/constants.dart';

enum AppThemeKeys { DAY, EVENING, NIGHT }

class AppThemes {
  static final fontFamily = 'BalooPaaji2';

  static final TextTheme textTheme = AppTextTheme.apply(
    bodyColor: defaultFontColor,
    displayColor: defaultFontColor,
  );

  static final ThemeData dayTheme = ThemeData(
    textTheme: textTheme,
    accentColor: dayThemeAccentColor,
    primaryColor: dayThemePrimaryColor,
    fontFamily: fontFamily,
  );

  static final ThemeData eveningTheme = ThemeData(
    textTheme: textTheme,
    accentColor: eveningThemeAccentColor,
    primaryColor: eveningThemePrimaryColor,
    fontFamily: fontFamily,
  );

  static final ThemeData nightTheme = ThemeData(
    textTheme: textTheme,
    accentColor: nightThemeAccentColor,
    primaryColor: nightThemePrimaryColor,
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
