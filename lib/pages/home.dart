import 'package:flutter/material.dart';
import 'package:forecast/pages/weather_animations_list.dart';
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
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Drawer(
          elevation: 0.0,
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text("Bruce Wayne"),
                      accountEmail: Text("bruce@wayne.inc"),
                      currentAccountPicture: CircleAvatar(
                        child: Text(
                          "B",
                          style: TextStyle(fontSize: 40.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      decoration: BoxDecoration(color: Colors.transparent),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesome5.moon,
                        color: Colors.white70,
                      ),
                      title: Text(
                        "Switch mode",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {
                          setState(() {
//                          mode = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        FontAwesomeIcons.heart,
                        color: Colors.white70,
                      ),
                      title: Text("Favourites"),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white70,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlareAnimationsPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        FontAwesomeIcons.cloudSunRain,
                        color: Colors.white70,
                      ),
                      title: Text("Weather Animations"),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        FontAwesomeIcons.cog,
                        color: Colors.white70,
                      ),
                      title: Text("Settings"),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white70,
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(
                        FontAwesomeIcons.powerOff,
                        color: Colors.white70,
                      ),
                      title: Text("Log out"),
                      trailing: Icon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
            ],
          ),
        ),
      ),
    );
  }
}
