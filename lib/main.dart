import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast/utils/themes/app_theme.dart';
import 'package:forecast/utils/themes/themes.dart';

import 'package:forecast/pages/splashscreen.dart';

void main() {
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
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
