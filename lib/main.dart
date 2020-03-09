import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:forecast/pages/home.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(Forecast());
}

class Forecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Forecast",
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        accentColor: Colors.grey,
        fontFamily: 'AvenirNextLTPro',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
