import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentWeatherDetails extends StatefulWidget {
  @override
  _CurrentWeatherDetailsState createState() => _CurrentWeatherDetailsState();
}

class _CurrentWeatherDetailsState extends State<CurrentWeatherDetails> {
  @override
  Widget build(BuildContext context) {
    Color _cardColor = Theme.of(context).primaryColor.withOpacity(0.4);
    return Container(
      height: double.infinity,
      width: double.infinity,
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
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Malabe".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: FlareActor(
                            "assets/flare_animations/weather_11d.flr",
                            fit: BoxFit.contain,
                            animation: "11d",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
                          "32 ‎°C",
                          style: TextStyle(
                            height: 0.8,
                            fontSize: 50.0,
                          ),
                        ),
                        Text(
                          "Few Clouds",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Feels like 36.15 °C",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 0.3,
                        color: _cardColor,
                        child: Container(
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      fontSize: 16.0,),
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
                        color: _cardColor,
                        child: Container(
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        color: _cardColor,
                        child: Container(
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        color: _cardColor,
                        child: Container(
                          height: 90.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Card(
                  elevation: 0.3,
                  color: _cardColor,
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
                  color: _cardColor,
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
