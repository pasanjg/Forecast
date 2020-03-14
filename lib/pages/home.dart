import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:forecast/models/open_weather_map_model.dart';
import 'package:forecast/pages/weather_animations_list.dart';
import 'package:flare_flutter/flare_actor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  OpenWeatherMapAPI openWeatherMapAPI = OpenWeatherMapAPI(cityName: "Malabe,LK", units: "metric", forecast: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Colors.blueAccent,
              Colors.lightBlueAccent,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Malabe, Sri Lanka"),
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: FlareActor(
                    "assets/flare_animations/weather_02d.flr",
                    fit: BoxFit.contain,
                    animation: "02d",
                  ),
                ),
                Text("25 C"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("temp_min: 25"),
                    Text("temp_max: 25"),
                    Text("pressure: 1009"),
                    Text("humidity: 88"),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text("OTHER DATA"),
                Text(openWeatherMapAPI.requestURL)
              ],
            )
          ],
        ),
      ),
    );
  }
}
