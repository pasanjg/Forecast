import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/models/open_weather_map_model.dart';
import 'package:flare_flutter/flare_actor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OpenWeatherMapAPI openWeatherMapAPI = OpenWeatherMapAPI(
    cityName: "Malabe,LK",
    // coordinates: {'lat': '6.9', 'lon': '75.9'},
    // zipCode: "10115",
    units: "metric",
    forecast: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
/*        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),*/
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            elevation: 1.0,
            color: Theme.of(context).accentColor,
            onSelected: (value) {},
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                enabled: false,
                value: "Toggle Mode",
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Switch mode",
                      style: TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: true,
                      onChanged: (value) {
                        setState(() {
//                          mode = value;
                        });
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Favourites",
                child: Text("Favourites"),
              ),
              PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ],
          ),
        ],
      ),
      body: Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    height: 20.0,
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
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: FlareActor(
                      "assets/flare_animations/weather_02d.flr",
                      fit: BoxFit.contain,
                      animation: "02d",
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "32 ‎°C",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
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
                            color: Colors.white.withOpacity(0.2),
                            child: Container(
                              height: 120.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.thermometerFull,
                                      color: Colors.white,
                                      size: 32.0,
                                    ),
                                    Text(
                                      "32 °C",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Max Temp",
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
                            color: Colors.white.withOpacity(0.2),
                            child: Container(
                              height: 120.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.thermometerQuarter,
                                      color: Colors.white,
                                      size: 32.0,
                                    ),
                                    Text(
                                      "32 °C",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Min Temp",
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
                            color: Colors.white.withOpacity(0.2),
                            child: Container(
                              height: 120.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesome.tachometer,
                                      color: Colors.white,
                                      size: 32.0,
                                    ),
                                    Text(
                                      "1009 hPa",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
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
                            color: Colors.white.withOpacity(0.2),
                            child: Container(
                              height: 120.0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Entypo.drop,
                                      color: Colors.white,
                                      size: 32.0,
                                    ),
                                    Text(
                                      "66%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0),
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
                    color: Colors.white.withOpacity(0.2),
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
                  Divider(
                    color: Colors.white.withOpacity(0.4),
                  ),
                ],
              ),
              Card(
                elevation: 0.3,
                color: Colors.white.withOpacity(0.2),
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
                                height: 40.0,
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
                                height: 40.0,
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
                                height: 40.0,
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
                                height: 40.0,
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
                                height: 40.0,
                                child: FlareActor(
                                  "assets/flare_animations/weather_50d.flr",
                                  fit: BoxFit.contain,
                                  animation: "50d",
                                ),
                              ),
                              Text("30 °C")
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
        ),
      ),
    );
  }
}
