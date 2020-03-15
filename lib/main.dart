import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:forecast/pages/home.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(Forecast());
}

class Forecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: "Forecast",
      theme: ThemeData(
        primaryColor: Colors.blueAccent[900], // dark shade
        accentColor: Colors.blueAccent, // light shade
        splashColor: Colors.white30,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              fontFamily: 'AvenirNextLTPro',
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
