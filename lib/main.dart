import 'package:flutter/material.dart';
import 'package:forecast/pages/home.dart';

void main() => runApp(Forecast());

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
