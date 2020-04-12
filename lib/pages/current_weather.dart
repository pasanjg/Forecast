import 'dart:async';
import 'package:flutter/material.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/shared_preferences.dart';
import 'package:forecast/utils/themes/app_theme.dart';
import 'package:forecast/utils/themes/themes.dart';
import 'package:intl/intl.dart';

import 'package:forecast/models/openweathermap_api.dart';
import 'package:forecast/widgets/current_weather/card_data.dart';
import 'package:forecast/widgets/current_weather/temp_data_card.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/blocs/current_weather/current_weather_bloc.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fl_chart/fl_chart.dart';

class CurrentWeatherDetailsPage extends StatefulWidget {
  @override
  _CurrentWeatherDetailsPageState createState() =>
      _CurrentWeatherDetailsPageState();
}

class _CurrentWeatherDetailsPageState extends State<CurrentWeatherDetailsPage> {
  OpenWeatherMapAPI openWeatherMapAPI;
  Geolocator geolocator = Geolocator();
  Position userLocation;
  DateTime locationDate;
  String units;
  String temperatureUnit;

  double _animatedHeight = 0;
  double _animatedMaxHeight = 250;
  ScrollController _controller = ScrollController();

  List<Color> gradientColors = [
    Colors.grey,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
      print(userLocation);
      openWeatherMapAPI = OpenWeatherMapAPI(
        coordinates: {
          'lat': userLocation.latitude.toString(),
          'lon': userLocation.longitude.toString(),
        },
        units: units,
      );
      currentWeatherBloc.fetchCurrentWeather(openWeatherMapAPI.requestURL);
    });

    AppSharedPreferences.getStringSharedPreferences("units").then((value) {
      setState(() {
        temperatureUnit = CommonUtils.getTemperatureUnit(value);
        units = value;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
//    currentWeatherBloc.dispose();
    super.dispose();
  }

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

  handleAutoScroll() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  getTodayDateTime(int timeZone) {
    DateTime today = new DateTime.now();

    if (timeZone >= 0) {
      this.locationDate = today
          .add(
            Duration(
              hours: DateFormat("ss").parse(timeZone.toString(), true).hour,
              minutes: DateFormat("ss").parse(timeZone.toString(), true).minute,
            ),
          )
          .toUtc();
    } else {
      timeZone *= -1;
      this.locationDate = today
          .subtract(
            Duration(
              hours: DateFormat("ss").parse(timeZone.toString(), true).hour,
              minutes: DateFormat("ss").parse(timeZone.toString(), true).minute,
            ),
          )
          .toUtc();
    }

    this.locationDate = locationDate;
    return DateFormat.yMMMMEEEEd().format(locationDate);
  }

  void _onAfterBuild(BuildContext context) {
    setState(() {
      if (locationDate != null)
        AppTheme.instanceOf(context)
            .changeTheme(AppThemes.getThemeKeyFromTime(locationDate));
    });
  }

  Widget _buildCurrentWeatherData(WeatherModel currentWeather) {
    Color _cardColor = Theme.of(context).primaryColor.withOpacity(0.8);
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (scroll) {
        scroll.disallowGlow();
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          controller: _controller,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.86,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        getTodayDateTime(currentWeather.timeZone),
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
                        currentWeather.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.width * 0.4,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: FlareActor(
                                  "assets/flare_animations/weather_icons/weather_${currentWeather.weatherIcon}.flr",
                                  fit: BoxFit.contain,
                                  animation: currentWeather.weatherIcon,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${currentWeather.temp}",
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 3.0,
                                      top: 7.0,
                                    ),
                                    child: Text(
                                      temperatureUnit,
                                      style: TextStyle(
                                        height: 1.2,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                currentWeather.weatherDescription.toUpperCase(),
                                style: TextStyle(fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "${currentWeather.feelsLike} ${temperatureUnit}",
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
                      /////// MAX.TEMP | MIN.TEMP | PRESSURE | HUMIDITY ////////
                      Row(
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
                                "${currentWeather.tempMax} ${temperatureUnit}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ),
                              bottomElement: Text(
                                "Max. Temp",
                                textAlign: TextAlign.center,
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
                                "${currentWeather.tempMin} ${temperatureUnit}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0),
                              ),
                              bottomElement: Text(
                                "Min. Temp",
                                textAlign: TextAlign.center,
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
                                "${currentWeather.pressure} hPa",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0),
                              ),
                              bottomElement: Text(
                                "Pressure",
                                textAlign: TextAlign.center,
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
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                ),
                              ),
                              bottomElement: Text(
                                "Humidity",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      /////////////////// END OF TEMP CARD DATA ////////////////

                      ////////////////////// OTHER DATA ////////////////////////
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
                                  Text("${currentWeather.clouds}%"),
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
                                  Text("${currentWeather.windSpeed} m/s"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      ////////////////// END OF OTHER DATA /////////////////////

                      InkWell(
                        onTap: () {
                          setState(() {
                            _animatedHeight =
                                _animatedHeight == _animatedMaxHeight
                                    ? 0
                                    : _animatedMaxHeight;
                          });

                          if (_animatedHeight == _animatedMaxHeight)
                            Timer(
                              Duration(milliseconds: 500),
                              handleAutoScroll,
                            );
                        },
                        ////////////////////////////////////////////////////////
                        child: Card(
                          elevation: 0.3,
                          color: _cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: IntrinsicHeight(
                              //////////////////////////////////////////////////
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text("SUN"),
                                        Container(
                                          height: 30.0,
                                          child: FlareActor(
                                            "assets/flare_animations/weather_icons/weather_02d.flr",
                                            fit: BoxFit.contain,
                                            animation: "02d",
                                          ),
                                        ),
                                        Text("30 $temperatureUnit")
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text("MON"),
                                        Container(
                                          height: 30.0,
                                          child: FlareActor(
                                            "assets/flare_animations/weather_icons/weather_11d.flr",
                                            fit: BoxFit.contain,
                                            animation: "11d",
                                          ),
                                        ),
                                        Text("30 $temperatureUnit")
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text("TUE"),
                                        Container(
                                          height: 30.0,
                                          child: FlareActor(
                                            "assets/flare_animations/weather_icons/weather_04d.flr",
                                            fit: BoxFit.contain,
                                            animation: "04d",
                                          ),
                                        ),
                                        Text("30 $temperatureUnit")
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text("WED"),
                                        Container(
                                          height: 30.0,
                                          child: FlareActor(
                                            "assets/flare_animations/weather_icons/weather_09d.flr",
                                            fit: BoxFit.contain,
                                            animation: "09d",
                                          ),
                                        ),
                                        Text("30 $temperatureUnit")
                                      ],
                                    ),
                                  ),
                                  VerticalDivider(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Text("THU"),
                                        Container(
                                          height: 30.0,
                                          child: FlareActor(
                                            "assets/flare_animations/weather_icons/weather_50d.flr",
                                            fit: BoxFit.contain,
                                            animation: "50d",
                                          ),
                                        ),
                                        Text("30 $temperatureUnit"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //////////////////////////////////////////////////
                            ),
                          ),
                        ),
                        ////////////////////////////////////////////////////////
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // TODAY'S FORECAST DETAILS //
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: AnimatedContainer(
                // color: Colors.red,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 500),
                height: _animatedHeight,
                child: AnimatedOpacity(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 500),
                  opacity: this._animatedHeight == this._animatedMaxHeight
                      ? 1.0
                      : 0.0,
                  child: Wrap(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: _animatedMaxHeight,
                            child: Card(
                              elevation: 0.3,
                              color: _cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                child: FlareActor(
                                                  "assets/flare_animations/weather_icons/weather_02d.flr",
                                                  fit: BoxFit.contain,
                                                  animation: "02d",
                                                ),
                                              ),
                                              Text("30 °C")
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                child: FlareActor(
                                                  "assets/flare_animations/weather_icons/weather_11d.flr",
                                                  fit: BoxFit.contain,
                                                  animation: "11d",
                                                ),
                                              ),
                                              Text("30 °C")
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                child: FlareActor(
                                                  "assets/flare_animations/weather_icons/weather_04d.flr",
                                                  fit: BoxFit.contain,
                                                  animation: "04d",
                                                ),
                                              ),
                                              Text("30 °C")
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                child: FlareActor(
                                                  "assets/flare_animations/weather_icons/weather_09d.flr",
                                                  fit: BoxFit.contain,
                                                  animation: "09d",
                                                ),
                                              ),
                                              Text("30 °C")
                                            ],
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 0.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 30.0,
                                                child: FlareActor(
                                                  "assets/flare_animations/weather_icons/weather_50d.flr",
                                                  fit: BoxFit.contain,
                                                  animation: "50d",
                                                ),
                                              ),
                                              Text("30 °C"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0, left: 8.0, right: 8.0),
                            child: AspectRatio(
                              aspectRatio: 5 / 2, // width / height
                              child: LineChart(
                                mainData(),
                              ),
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
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 10,
      minY: 25.75,
      maxY: 33.55,
      lineBarsData: [
        LineChartBarData(
          spots: const [
//            FlSpot(0, 28.75),
            FlSpot(1, 25.75),
            FlSpot(3, 31.97),
            FlSpot(5, 33.55),
            FlSpot(7, 28.52),
            FlSpot(9, 26.46),
//            FlSpot(10, 30.46),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
            dotColor: Colors.white,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onAfterBuild(context));
    return StreamBuilder(
      stream: currentWeatherBloc.currentWeather,
      builder: (context, AsyncSnapshot<WeatherModel> snapshot) {
        if (snapshot.hasData) {
          return _buildCurrentWeatherData(snapshot.data);
        } else if (snapshot.hasError) {
          Fluttertoast.showToast(msg: snapshot.error);
          return Center(child: Text(snapshot.error));
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          );
        }
      },
    );
  }
}
