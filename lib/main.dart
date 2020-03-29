import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
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
//        primaryColor: Colors.blueAccent[900], // dark shade
//        accentColor: Colors.blueAccent, // light shade
        primaryColor: Color(0xFF010A26), // dark shade
        accentColor: Color(0xFF010A5D), // light shade
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              fontFamily: 'AvenirNextLTPro',
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  setTimer() async {
    Duration _duration = Duration(seconds: 3);
    return Timer(_duration, navigateToHome);
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
//              Color(0xFF010A5D), // light color
//              Color(0xFF010A26), // dark color
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: FlareActor(
              "assets/flare_animations/world_spin.flr",
              animation: "roll",
            ),
          ),
        ),
      ),
    );
  }
}
