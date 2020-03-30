import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:forecast/pages/splashscreen.dart';
import 'package:forecast/themes/app_theme.dart';
import 'package:forecast/themes/themes.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(
    AppTheme(
      child: Forecast(),
    ),
  );
}

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  DateTime _dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  AppThemeKeys updateTheme() {
    _dateTime = DateTime.now();
    int _currentHour = _dateTime.hour;
    print(_currentHour);

    if (_currentHour >= 6 && _currentHour <= 15) {
      return AppThemeKeys.DAY;
    }
    else if (_currentHour >= 16 && _currentHour <= 18) {
      return AppThemeKeys.EVENING;
    } else {
      return AppThemeKeys.NIGHT;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: "Forecast",
      theme: AppThemes.getThemeFromKey(updateTheme()),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
