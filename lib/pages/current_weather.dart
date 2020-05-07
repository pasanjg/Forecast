import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forecast/pages/weather_forecast.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/widgets/error/no_internet.dart';
import 'package:forecast/utils/animations/FadeAnimation.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/shared_preferences.dart';
import 'package:forecast/utils/themes/app_theme.dart';
import 'package:forecast/utils/themes/themes.dart';
import 'package:forecast/widgets/error/something_went_wrong.dart';
import 'package:intl/intl.dart';

import 'package:forecast/models/openweathermap_api.dart';
import 'package:forecast/widgets/current_weather/card_data.dart';
import 'package:forecast/widgets/current_weather/temp_data_card.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/blocs/current_weather_bloc.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class CurrentWeatherDetailsPage extends StatefulWidget {
  final String cityName;

  CurrentWeatherDetailsPage({Key key, this.cityName}) : super(key: key);

  @override
  _CurrentWeatherDetailsPageState createState() =>
      _CurrentWeatherDetailsPageState();
}

class _CurrentWeatherDetailsPageState extends State<CurrentWeatherDetailsPage> {
  bool hasInternet = true;
  OpenWeatherMapAPI openWeatherMapAPI;
  Geolocator geolocator = Geolocator();
  Position userLocation;
  DateTime locationDate;
  String cityName;
  String country;
  int timeZone;
  int _sunRise;
  int _sunSet;
  bool isSaved = false;
  String userId;
  String units;
  String temperatureUnit;
  bool hasError = false;

  List savedLocations;
  DocumentReference documentReference;
  ScrollController _controller;

  final GlobalKey<WeatherForecastPageState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    checkInternet();
    _fetchData();

    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    currentWeatherBloc.dispose();
  }

  Future<void> _fetchData() async {
    units = await AppSharedPreferences.getStringSharedPreferences("units");
    temperatureUnit = getTemperatureUnit(units);

    if (widget.cityName == null) {
      userLocation = await _getLocation();

      if (userLocation != null) {
        var address = await _getLocationAddress(userLocation);

        if (address != null && address[0].locality != "") {
          setState(() {
            this.cityName =
                "${address[0].locality},${address[0].isoCountryCode}";
            openWeatherMapAPI = OpenWeatherMapAPI(
              cityName: this.cityName,
              units: units,
            );
          });
        } else {
          setState(() {
            openWeatherMapAPI = OpenWeatherMapAPI(
              coordinates: {
                'lat': userLocation.latitude,
                'lon': userLocation.longitude
              },
              units: units,
            );
          });
        }
        currentWeatherBloc.fetchCurrentWeather(openWeatherMapAPI.requestURL);
      } else {
        showFlutterToast("Oops! We cannot locate you");
      }
    } else {
      setState(() {
        this.cityName = widget.cityName;
      });
      openWeatherMapAPI = OpenWeatherMapAPI(
        cityName: this.cityName,
        units: units,
      );
      currentWeatherBloc.fetchCurrentWeather(openWeatherMapAPI.requestURL);
    }
    _checkSavedLocations();
  }

  Future<void> _pullRefresh() async {
    await _fetchData();
    await _key.currentState.fetchData();
    showFlutterToast("You're up-to-date");
  }

  /// Code referred from Stackoverflow.
  /// See <https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app> for source.
  void checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          hasInternet = true;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        hasInternet = false;
      });
    }
  }

  /// Code referred from pub.dev
  /// See <https://pub.dev/packages/geolocator> for source.
  Future<Position> _getLocation() async {
    var currentLocation;

    try {
      currentLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (e) {
      currentLocation = null;
    }

    return currentLocation;
  }

  /// Code referred from pub.dev
  /// See <https://pub.dev/packages/geolocator> for source.
  Future<List<Placemark>> _getLocationAddress(Position userLocation) async {
    var latitude = userLocation.latitude;
    var longitude = userLocation.longitude;

    try {
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
        latitude,
        longitude,
      );

      return placemark;
    } catch (e) {
      setState(() {
        hasError = true;
      });
      showFlutterToast("Error locating your position", isLong: true);
    }
    return null;
  }

  /// Code referred from flutter.dev
  /// See <https://api.flutter.dev/flutter/dart-core/DateTime/add.html> for source.
  String _getTodayDate(int timeZone) {
    DateTime today = DateTime.now();

    if (timeZone >= 0) {
      locationDate = today
          .add(
            Duration(
              hours: DateFormat("ss").parse(timeZone.toString(), true).hour,
              minutes: DateFormat("ss").parse(timeZone.toString(), true).minute,
            ),
          )
          .toUtc();
    } else {
      timeZone *= -1;
      locationDate = today
          .subtract(
            Duration(
              hours: DateFormat("ss").parse(timeZone.toString(), true).hour,
              minutes: DateFormat("ss").parse(timeZone.toString(), true).minute,
            ),
          )
          .toUtc();
    }

    return DateFormat.yMMMMEEEEd().format(locationDate);
  }

  /// Code referred from Firebase Auth.
  /// See <https://pub.dev/packages/firebase_auth> for source.
  Future<void> _getUserId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      if (user != null) {
        userId = user.uid;
      }
    });
  }

  /// Code referred from Stackoverflow.
  /// See <https://stackoverflow.com/questions/50471309/how-to-listen-for-document-changes-in-cloud-firestore-using-flutter> for source.
  Future<void> _checkSavedLocations() async {
    await _getUserId();

    if (userId != null) {
      Firestore.instance
          .collection(usersCollection)
          .document(userId)
          .snapshots()
          .listen((DocumentSnapshot documentSnapshot) {
        Map<String, dynamic> documentData = documentSnapshot.data;
        if (this.mounted) {
          setState(() {
            savedLocations = documentData[userSavedLocations];
            if (savedLocations != null && savedLocations.isNotEmpty) {
              isSaved = savedLocations.contains(this.cityName);
            } else {
              isSaved = false;
            }
          });
        }
      });
    }
  }

  /// Code referred from Stackoverflow.
  /// See <https://stackoverflow.com/questions/52150545/how-to-add-or-remove-item-to-the-the-existing-array-in-firestore/53149420#53149420> for source.
  void _handleSave(bool isSaved, String cityName) async {
    if (userId == null) {
      showFlutterToast("You need to be logged in");
      return;
    }

    if (!cityName.contains(",")) {
      cityName = "$cityName,${this.country}";
    }

    this.documentReference =
        Firestore.instance.collection(usersCollection).document(this.userId);

    if (isSaved) {
      this.documentReference.updateData({
        userSavedLocations: FieldValue.arrayRemove([cityName])
      });
      setState(() {
        this.isSaved = false;
      });
      showFlutterToast("Location removed");
    } else {
      this.documentReference.updateData({
        userSavedLocations: FieldValue.arrayUnion([cityName])
      });
      setState(() {
        this.isSaved = true;
      });
      showFlutterToast("Location saved");
    }
  }

  /// Code referred from a Medium post.
  /// See <https://medium.com/flutter-community/dynamic-theming-with-flutter-78681285d85f> for source.
  void _onAfterBuild(BuildContext context) {
    setState(() {
      if (this.locationDate != null)
        AppTheme.instanceOf(context).changeTheme(
          AppThemes.getThemeKeyFromTime(
            this.locationDate,
            sunRise: this._sunRise,
            sunSet: this._sunSet,
            timeZone: this.timeZone,
          ),
        );
    });
  }

  Widget _buildCurrentWeatherData(WeatherModel currentWeather) {
    Color _cardColor = Colors.black.withAlpha(20);

    /// Code referred from Stackoverflow.
    /// See <https://stackoverflow.com/questions/50899640/how-to-remove-listview-highlight-color-in-flutter> for source.
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (scroll) {
        scroll.disallowGlow();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.685,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FadeAnimation(
                        delay: 0.5,
                        child: Column(
                          children: <Widget>[
                            Text(
                              _getTodayDate(currentWeather.timeZone),
                              style: TitleTextStyle.apply(
                                letterSpacingFactor: 1.2,
                              ),
                            ),
                            Text(
                              currentWeather.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: HeadingTextStyle.apply(
                                heightFactor: 1.2,
                                letterSpacingFactor: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      FadeAnimation(
                        delay: 0.8,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: FlareActor(
                                    "assets/flare_animations/weather_icons/weather_${currentWeather.weatherIcon}.flr",
                                    fit: BoxFit.contain,
                                    animation: currentWeather.weatherIcon,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        currentWeather.temp,
                                        style: MainTextStyle.apply(
                                          fontSizeFactor: 1.1,
                                          heightFactor: 0.5,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                        ),
                                        child: Text(
                                          temperatureUnit,
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            height: 0.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          currentWeather.weatherDescription
                                              .toUpperCase(),
                                          textAlign: TextAlign.right,
                                          style: RegularTextStyle,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Text(
                                          "FEELS  ${currentWeather.feelsLike} $temperatureUnit",
                                          style: RegularTextStyle.apply(
                                            fontSizeFactor: 0.85,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 5.0,
                        ),
                        child: FadeAnimation(
                          delay: 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 3.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.clock,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          DateFormat.jm()
                                              .format(
                                                getTime(
                                                    ((locationDate
                                                                .millisecondsSinceEpoch) /
                                                            1000)
                                                        .round(),
                                                    0),
                                              )
                                              .toString(),
                                          style: MediumTextStyle,
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                flex: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _handleSave(isSaved, this.cityName);
                                        });
                                      },
                                      child: Container(
                                        child: isSaved
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.redAccent,
                                                size: 35.0,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: Colors.white30,
                                                size: 35.0,
                                              ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                      height: 40.0,
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            "assets/images/flag-loading.png",
                                        image:
                                            "https://www.countryflags.io/${this.country}/flat/64.png",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        delay: 1.4,
                        child: Row(
                          children: <Widget>[
                            TempDataCard(
                              cardColor: _cardColor,
                              cardData: CardData(
                                topElement: Icon(
                                  FontAwesomeIcons.thermometerFull,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                middleElement: Text(
                                  "${currentWeather.tempMax}$temperatureUnit",
                                  style: RegularTextStyle,
                                ),
                                bottomElement: Text(
                                  "Max. Temp",
                                  textAlign: TextAlign.center,
                                  style: SmallTextStyle,
                                ),
                              ),
                            ),
                            TempDataCard(
                              cardColor: _cardColor,
                              cardData: CardData(
                                topElement: Icon(
                                  FontAwesomeIcons.thermometerQuarter,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                middleElement: Text(
                                  "${currentWeather.tempMin}$temperatureUnit",
                                  style: RegularTextStyle,
                                ),
                                bottomElement: Text(
                                  "Min. Temp",
                                  textAlign: TextAlign.center,
                                  style: SmallTextStyle,
                                ),
                              ),
                            ),
                            TempDataCard(
                              cardColor: _cardColor,
                              cardData: CardData(
                                topElement: Icon(
                                  FontAwesome.tachometer,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                middleElement: Text(
                                  "${currentWeather.pressure}hPa",
                                  style: RegularTextStyle,
                                ),
                                bottomElement: Text(
                                  "Pressure",
                                  textAlign: TextAlign.center,
                                  style: SmallTextStyle,
                                ),
                              ),
                            ),
                            TempDataCard(
                              cardColor: _cardColor,
                              cardData: CardData(
                                topElement: Icon(
                                  Entypo.drop,
                                  color: Colors.white,
                                  size: 24.0,
                                ),
                                middleElement: Text(
                                  "${currentWeather.humidity}%",
                                  style: RegularTextStyle,
                                ),
                                bottomElement: Text(
                                  "Humidity",
                                  textAlign: TextAlign.center,
                                  style: SmallTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeAnimation(
                        delay: 1.4,
                        child: Card(
                          elevation: 0.3,
                          color: _cardColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Feather.sunrise,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      DateFormat.jm()
                                          .format(getTime(
                                            currentWeather.sunRise,
                                            currentWeather.timeZone,
                                          ))
                                          .toString(),
                                      style: SmallTextStyle.apply(
                                        heightFactor: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.cloud,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      "${currentWeather.clouds}%",
                                      style: SmallTextStyle.apply(
                                        heightFactor: 2,
                                      ),
                                    ),
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
                                    Text(
                                      "${currentWeather.windSpeed} m/s",
                                      style: SmallTextStyle.apply(
                                        heightFactor: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Feather.sunset,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      DateFormat.jm()
                                          .format(getTime(
                                            currentWeather.sunSet,
                                            currentWeather.timeZone,
                                          ))
                                          .toString(),
                                      style: SmallTextStyle.apply(
                                        heightFactor: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ////////////////// END OF OTHER DATA /////////////////////
                // TODAY'S FORECAST DETAILS //
                FadeAnimation(
                  delay: 1.6,
                  child: WeatherForecastPage(
                    key: _key,
                    controller: _controller,
                    cityName: cityName,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Code referred from Stackoverflow.
    /// See <https://stackoverflow.com/questions/51216448/is-there-any-callback-to-tell-me-when-build-function-is-done-in-flutter> for source.
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild(context));

    /// Code referred from flutter.dev
    /// See <https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html> for source.
    return StreamBuilder(
      stream: currentWeatherBloc.currentWeather,
      builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.cod == "200") {
            this.country = snapshot.data.country;
            if (this.cityName == null) {
              this.cityName = snapshot.data.name + "," + snapshot.data.country;
            }
            this.timeZone = snapshot.data.timeZone;
            this._sunRise = snapshot.data.sunRise;
            this._sunSet = snapshot.data.sunSet;
            return RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: _pullRefresh,
              child: GestureDetector(
                onDoubleTap: () {
                  String details = this.cityName;
                  _handleSave(isSaved, details);
                },
                child: _buildCurrentWeatherData(snapshot.data),
              ),
            );
          } else {
            return Center(
              child: SomethingWentWrong(
                message: snapshot.data.error.toUpperCase(),
              ),
            );
          }
        } else if (snapshot.hasError || hasError) {
          return Center(
            child: SomethingWentWrong(),
          );
        } else {
          if (hasInternet) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          } else {
            return NoInternet();
          }
        }
      },
    );
  }
}
