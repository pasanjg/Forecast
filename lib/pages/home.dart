import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forecast/pages/saved_locations.dart';
import 'package:forecast/pages/weather_animations_list.dart';
import 'package:forecast/pages/login.dart';
import 'package:forecast/utils/animations/FadeAnimation.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert' as convert;

import 'package:forecast/models/user.dart';
import 'package:forecast/utils/common/user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:forecast/pages/current_weather.dart';
import 'package:forecast/pages/settings.dart';
import 'package:forecast/widgets/background/default_gradient.dart';
import 'package:forecast/pages/profile.dart';

class HomePage extends StatefulWidget {
  final String cityName;

  HomePage({Key key, this.cityName}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchTextField = TextEditingController();
  UserProfileService db = new UserProfileService();
  String _searchText = " ";
  List cities = new List();
  List filteredCities = List();
  Icon _searchIcon = Icon(Icons.search);
  bool isSearching = false;
  String cityName;
  String savedLocation;
  String _uid;
  User _user;
  String _fName;
  String _lName;
  String _email;
  String _url;
  bool _loginStatus = false;

  @override
  void initState() {
    super.initState();
    _currentUser();
    this._getCities();
    this.savedLocation = widget.cityName;
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
      this.savedLocation = null;
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
                      this.savedLocation = null;
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

  void _currentUser() async {
    final FirebaseUser user = (await _auth.currentUser());
    if (user != null) {
      setState(() {
        _uid = user.uid;
        _loginStatus = true;
      });
      DocumentSnapshot snapshot = await db.getUserById(_uid);
      print(snapshot.data);
      _user = new User(snapshot.data['id'], snapshot.data['firstName'],
          snapshot.data['lastName'], snapshot.data['email'], snapshot.data['imageUrl']);
      _email = _user.email;
      _fName = _user.firstName;
      _lName = _user.lastName;
      _url = _user.imageUrl;
//      _getImageUrl();
    } else {
      print("Unsuccess!");
    }
  }

//  void _getImageUrl() {
//    StorageReference ref = FirebaseStorage.instance.ref().child("images/$_uid");
//    String _url = ref.getDownloadURL().toString();
//    url = _url;
//  }

  void _logout() async {
    await _auth.signOut();
    _loginStatus = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    if (savedLocation != null) {
      this.cityName = savedLocation;
    }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _user != null
                          ? GestureDetector(
                              child: UserAccountsDrawerHeader(
                                accountName: Text(
                                  _user.firstName + " " + _user.lastName,
                                  style: RegularTextStyle,
                                ),
                                accountEmail: Text(
                                  _user.email,
                                  style: SmallTextStyle,
                                ),
                                currentAccountPicture: CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 140.0,
                                      height: 140.0,
                                      child: _url == null
                                          ? Image.asset(
                                              'assets/images/forecast-logo.png',
                                            )
                                          : Image.network(_url),
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, top: 40.0, bottom: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: AssetImage(
                                        "assets/images/forecast-logo.png"),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    "Login to Forecast for more features",
                                    style: SmallTextStyle,
                                  ),
                                ],
                              ),
                            ),
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavedLocationsPage(),
                            ),
                          );
                        },
                        leading: Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white70,
                        ),
                        title: Text(
                          "Saved Locations",
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
                          if (_loginStatus) {
                            _logout();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          } else {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        leading: Icon(
                          FontAwesomeIcons.powerOff,
                          color: Colors.white70,
                        ),
                        title: Text(
                          _loginStatus == true ? "Logout" : "Login",
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
