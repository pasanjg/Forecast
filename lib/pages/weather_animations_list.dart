import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class FlareAnimationsPage extends StatefulWidget {
  @override
  _FlareAnimationsPageState createState() => _FlareAnimationsPageState();
}

class _FlareAnimationsPageState extends State<FlareAnimationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text("Temp Page"),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 4,
          children: <Widget>[
            FlareActor(
              "assets/flare_animations/weather_icons/weather_01d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "01d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_01n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "01n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_02d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "02d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_02n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "02n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_03d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "03d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_03n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "03n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_04d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "04d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_04n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "04n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_09d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "09d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_09n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "09n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_10d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "10d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_10n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "10n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_11d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "11d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_11n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "11n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_13d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "13d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_13n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "13n",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_50d.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "50d",
            ),
            FlareActor(
              "assets/flare_animations/weather_icons/weather_50n.flr",
              fit: BoxFit.contain,
              alignment: Alignment.center,
              animation: "50n",
            ),
          ],
        ),
      ),
    );
  }
}
