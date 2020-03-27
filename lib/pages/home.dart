import 'package:flutter/material.dart';
import 'package:forecast/pages/weather_animations_list.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/models/open_weather_map_api.dart';
import 'dart:convert' as convert;

import 'package:forecast/components/current_weather.dart';

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

  final TextEditingController _searchTextField = TextEditingController();
  String _searchText = " ";
  List cities = new List();
  List filteredCities = new List();
  Icon _searchIcon = new Icon(Icons.search);
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    this._getCities();
  }

  _HomePageState() {
    _searchTextField.addListener(() {
      setState(() {
        if (_searchTextField.text.isEmpty) {
          _searchText = "";
          filteredCities = cities;
        } else {
          _searchText = _searchTextField.text;
          print(_searchText);
        }
      });
    });
  }

  void _getCities() async {
    final response = await DefaultAssetBundle.of(context)
        .loadString("assets/json/current_city_list_min.json");
    final jsonResponse = convert.jsonDecode(response);
    List tempList = new List();
    for (int i = 0; i < jsonResponse.length; i++) {
      tempList.add(jsonResponse[i]);
      print(jsonResponse.length);
    }
    setState(() {
      cities = tempList;
      filteredCities = cities;
    });
  }

  Widget _appBarTitle() {
    return isSearching
        ? TextField(
            controller: _searchTextField,
            decoration: InputDecoration.collapsed(
              hintText: "Search city name",
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          )
        : Text(" ");
  }

  void _onSearchPressed() {
    setState(() {
      isSearching = isSearching ? false : true;
      if (isSearching) {
        _searchIcon = Icon(Icons.close);
      } else {
        _searchIcon = Icon(Icons.search);
        filteredCities = cities;
        _searchTextField.clear();
      }
    });
  }

  Widget _searchList() {
    print(filteredCities.length);
    if (_searchText.isNotEmpty) {
      List tempList = List();
      for (int i = 0; i < filteredCities.length; i++) {
        if (filteredCities[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredCities[i]);
        }
      }
      filteredCities = tempList;
    }

    return Container(
      color: Colors.black.withOpacity(0.9),
      child: ListView.builder(
        itemCount: filteredCities.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {},
            title: Text(
              "${filteredCities[index]['name']}",
            ),
            trailing: Container(
              height: 30.0,
              child: Image.network(
                "https://www.countryflags.io/${filteredCities[index]['country']}/flat/64.png",
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _snappedScroll(int itemIndex) {
    switch (itemIndex) {
      case 0:
        {
          return CurrentWeatherDetails();
        }
        break;

      case 1:
        {
          return Text(
            "TODAY FORECAST DETAILS",
            style: TextStyle(fontSize: 20.0),
          );
        }
        break;

      default:
        {
          return CurrentWeatherDetails();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: _appBarTitle(),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        actions: <Widget>[
          IconButton(
            onPressed: _onSearchPressed,
            icon: _searchIcon,
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
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
                          style: TextStyle(fontSize: 30.0),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
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
      body: isSearching
          ? _searchList()
          : Container(
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
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: PageController(viewportFraction: 1),
                itemCount: 2,
                itemBuilder: (BuildContext context, int itemIndex) {
                  return _snappedScroll(itemIndex);
                },
              ),
            ),
    );
  }
}
