import 'package:flutter/material.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/constants.dart';

/// Code referred from a Medium post.
/// See <https://medium.com/flutter-community/dynamic-theming-with-flutter-78681285d85f> for source.

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
    canvasColor: canvasColor,
    fontFamily: fontFamily,
  );

  static final ThemeData eveningTheme = ThemeData(
    textTheme: textTheme,
    accentColor: eveningThemeAccentColor,
    primaryColor: eveningThemePrimaryColor,
    canvasColor: canvasColor,
    fontFamily: fontFamily,
  );

  static final ThemeData nightTheme = ThemeData(
    textTheme: textTheme,
    accentColor: nightThemeAccentColor,
    primaryColor: nightThemePrimaryColor,
    canvasColor: canvasColor,
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

  static AppThemeKeys getThemeKeyFromTime(DateTime locationDate,
      {int sunRise, int sunSet, int timeZone}) {
    int _currentHour = locationDate.hour;

    if (sunRise != null && sunSet != null && timeZone != null) {
      DateTime sunRiseTime = getTime(sunRise, timeZone);
      DateTime sunSetTime = getTime(sunSet, timeZone);

      if (locationDate.compareTo(sunRiseTime) >= 0 && _currentHour <= 15) {
        return AppThemeKeys.DAY;
      } else if (_currentHour >= 16 &&
          locationDate.compareTo(sunSetTime) <= 0) {
        return AppThemeKeys.EVENING;
      } else {
        return AppThemeKeys.NIGHT;
      }
    } else {
      if (_currentHour >= 6 && _currentHour <= 15) {
        return AppThemeKeys.DAY;
      } else if (_currentHour >= 16 && _currentHour <= 17) {
        return AppThemeKeys.EVENING;
      } else {
        return AppThemeKeys.NIGHT;
      }
    }
  }
}
