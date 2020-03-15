import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 1.0],
          colors: <Color>[
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Malabe, Sri Lanka",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: FlareActor(
                      "assets/flare_animations/weather_02d.flr",
                      fit: BoxFit.contain,
                      animation: "02d",
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Few Clouds",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      "32 ‎°C",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 38.0,
                      ),
                    ),
                    Text(
                      "Feels like 36.15 °C",
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Card(
                          elevation: 0.3,
                          color: Colors.white.withOpacity(0.15),
                          child: Container(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.thermometerFull,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  Text(
                                    "32 °C",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "Max. Temp",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 0.3,
                          color: Colors.white.withOpacity(0.15),
                          child: Container(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.thermometerQuarter,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  Text(
                                    "32 °C",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "Min. Temp",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 0.3,
                          color: Colors.white.withOpacity(0.15),
                          child: Container(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(
                                    FontAwesome.tachometer,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  Text(
                                    "1009 hPa",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "Preassure",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 0.3,
                          color: Colors.white.withOpacity(0.15),
                          child: Container(
                            height: 80.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Icon(
                                    Entypo.drop,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                  Text(
                                    "66%",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    "Humidity",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 0.3,
                  color: Colors.white.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.cloud,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            SizedBox(width: 15.0),
                            Text("29%"),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.wind,
                              color: Colors.white,
                              size: 15.0,
                            ),
                            SizedBox(width: 15.0),
                            Text("2.1 m/s"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0.3,
                  color: Colors.white.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Sun"),
                                Container(
                                  height: 30.0,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_02d.flr",
                                    fit: BoxFit.contain,
                                    animation: "02d",
                                  ),
                                ),
                                Text("30 °C")
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Sun"),
                                Container(
                                  height: 30.0,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_11d.flr",
                                    fit: BoxFit.contain,
                                    animation: "11d",
                                  ),
                                ),
                                Text("30 °C")
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Sun"),
                                Container(
                                  height: 30.0,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_04d.flr",
                                    fit: BoxFit.contain,
                                    animation: "04d",
                                  ),
                                ),
                                Text("30 °C")
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Sun"),
                                Container(
                                  height: 30.0,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_09d.flr",
                                    fit: BoxFit.contain,
                                    animation: "09d",
                                  ),
                                ),
                                Text("30 °C")
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text("Sun"),
                                Container(
                                  height: 30.0,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_50d.flr",
                                    fit: BoxFit.contain,
                                    animation: "50d",
                                  ),
                                ),
                                Text("30 °C"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
