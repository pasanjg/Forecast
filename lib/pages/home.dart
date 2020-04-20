import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast/utils/animations/FadeAnimation.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' as convert;

import 'package:forecast/pages/current_weather.dart';
import 'package:forecast/pages/settings.dart';
import 'package:forecast/pages/weather_animations_list.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchTextField = TextEditingController();
  String _searchText = " ";
  List cities = new List();
  List filteredCities = List();
  Icon _searchIcon = Icon(Icons.search);
  bool isSearching = false;
  String cityName;

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
    }
    setState(() {
      cities = tempList;
      filteredCities = cities;
    });
  }

  Widget _appBarTitle() {
    return isSearching
        ? TextField(
            autofocus: true,
            controller: _searchTextField,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Where do you want to check?",
              hintStyle: TextStyle(
                color: Colors.white70,
              ),
            ),
          )
        : Text(" ");
  }

  void _onSearchPressed() {
    setState(() {
      if (_searchTextField.text == "" || _searchTextField.text == null) {
        isSearching = isSearching ? false : true;
        if (isSearching) {
          _searchIcon = Icon(Icons.close);
        } else {
          _searchIcon = Icon(Icons.search);
          filteredCities = cities;
          _searchTextField.clear();
        }
      } else {
        _searchTextField.text = "";
      }
    });
  }

  Widget _searchList() {
    if (_searchText.isNotEmpty) {
      List tempList = List();
      for (int i = 0; i < cities.length; i++) {
        if (cities[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(cities[i]);
        }
      }
      filteredCities = tempList;
    }

    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            setState(() {
              _searchTextField.text = "";
              this.cityName = null;
            });
            _onSearchPressed();
          },
          title: Row(
            children: <Widget>[
              Icon(FontAwesome.location_arrow, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                "Current Location",
                style: RegularTextStyle,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredCities.length,
            itemBuilder: (BuildContext context, int index) {
              return FadeAnimation(
                delay: index * 0.001,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      this.cityName =
                          "${filteredCities[index]['name']},${filteredCities[index]['country']}";
                      print(filteredCities[index]['name'] +
                          "," +
                          filteredCities[index]['country']);
                    });
                    _searchTextField.text = "";
                    _onSearchPressed();
                  },
                  title: Text(
                    "${filteredCities[index]['name']}",
                    style: RegularTextStyle,
                  ),
                  trailing: Container(
                    height: 30.0,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/images/flag-loading.png",
                      image:
                          "https://www.countryflags.io/${filteredCities[index]['country']}/flat/64.png",
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return WillPopScope(
      onWillPop: () async {
        if (this.isSearching) {
          setState(() {
            _searchTextField.text = "";
            this._onSearchPressed();
          });
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
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
                        accountName: Text(
                          "Bruce Wayne",
                          style: RegularTextStyle,
                        ),
                        accountEmail: Text(
                          "bruce@wayne.inc",
                          style: RegularTextStyle,
                        ),
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
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white70,
                        ),
                        title: Text(
                          "Favourites",
                          style: RegularTextStyle,
                        ),
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
                        title: Text(
                          "Weather Animations",
                          style: RegularTextStyle,
                        ),
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
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsPage(),
                            ),
                          );
                        },
                        leading: Icon(
                          FontAwesomeIcons.cog,
                          color: Colors.white70,
                        ),
                        title: Text(
                          "Settings",
                          style: RegularTextStyle,
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.angleRight,
                          color: Colors.white70,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        leading: Icon(
                          FontAwesomeIcons.powerOff,
                          color: Colors.white70,
                        ),
                        title: Text(
                          "Log out",
                          style: RegularTextStyle,
                        ),
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
        body: DefaultGradient(
          child: isSearching
              ? _searchList()
              : CurrentWeatherDetailsPage(cityName: this.cityName),
        ),
      ),
    );
  }
}
