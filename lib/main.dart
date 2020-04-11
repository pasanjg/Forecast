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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: "Forecast",
      theme: AppTheme.of(context) == null
          ? AppThemes.setCurrentDynamicTheme()
          : AppTheme.of(context),
//    theme: AppThemes.getThemeFromKey(AppThemeKeys.EVENING),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
