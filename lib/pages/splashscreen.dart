import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:forecast/pages/home.dart';

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
        color: Theme.of(context).primaryColor,
//        decoration: BoxDecoration(
//          gradient: RadialGradient(
//            stops: [0.1, 0.5],
//            colors: [
//              Theme.of(context).primaryColor,
//              Theme.of(context).accentColor,
//            ],
//          ),
//        ),
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
