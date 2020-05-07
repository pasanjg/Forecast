import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/blocs/weather_forecast_bloc.dart';
import 'package:forecast/models/openweathermap_api.dart';
import 'package:forecast/models/weather_forecast_model.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/utils/common/shared_preferences.dart';
import 'package:forecast/widgets/loading/weather_forecast_loading.dart';
import 'package:intl/intl.dart';

class WeatherForecastPage extends StatefulWidget {
  final ScrollController controller;
  final cityName;

  WeatherForecastPage({
    Key key,
    this.controller,
    this.cityName,
  }) : super(key: key);

  @override
  WeatherForecastPageState createState() => WeatherForecastPageState();
}

class WeatherForecastPageState extends State<WeatherForecastPage>
    with SingleTickerProviderStateMixin {
  String units;
  String temperatureUnit;

  DateTime today = DateTime.now();
  AnimationController _animationController;

  List<Color> graphGradient = [
    Colors.grey,
    Colors.white,
  ];

  double _animatedHeight = 0;
  double _animatedMaxHeight = 150;

  @override
  void initState() {
    super.initState();
    this._animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  Future<void> fetchData() async {
    units = await AppSharedPreferences.getStringSharedPreferences("units");
    temperatureUnit = getTemperatureUnit(units);

    OpenWeatherMapAPI openWeatherMapAPI = OpenWeatherMapAPI(
      cityName: widget.cityName,
      forecast: true,
      units: units,
    );
    weatherForecastBloc.fetchWeatherForecast(openWeatherMapAPI.requestURL);
  }

  _handleAutoScroll() {
    widget.controller.animateTo(
      widget.controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  /// Code referred from pub.dev
  /// See <https://pub.dev/packages/fl_chart> for source.
  LineChartData mainData(List<WeatherModel> weatherData) {
    double min = double.parse(weatherData[0].temp);
    double max = double.parse(weatherData[0].temp);

    for (int i = 0; i < 5; i++) {
      if (min > double.parse(weatherData[i].temp)) {
        min = double.parse(weatherData[i].temp);
      }

      if (max < double.parse(weatherData[i].temp)) {
        max = double.parse(weatherData[i].temp);
      }
    }

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
      minY: min - 2,
      maxY: max + 5,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, double.parse(weatherData[0].temp)),
            FlSpot(3, double.parse(weatherData[1].temp)),
            FlSpot(5, double.parse(weatherData[2].temp)),
            FlSpot(7, double.parse(weatherData[3].temp)),
            FlSpot(9, double.parse(weatherData[4].temp)),
          ],
          isCurved: true,
          colors: graphGradient,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
            dotColor: Colors.white,
          ),
          belowBarData: BarAreaData(
            show: false,
            colors:
                graphGradient.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherForecastData(WeatherForecastModel weatherForecast) {
    Color _cardColor = Colors.black.withAlpha(20);
    final rotateAnimation = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: this._animationController,
        curve: Curves.easeInOut,
      ),
    );

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              _animatedHeight = _animatedHeight == _animatedMaxHeight
                  ? 0
                  : _animatedMaxHeight;

              _animatedHeight == _animatedMaxHeight
                  ? _animationController.forward()
                  : _animationController.reverse();
            });

            if (_animatedHeight == _animatedMaxHeight)
              Timer(
                Duration(milliseconds: 500),
                _handleAutoScroll,
              );
          },
          child: Card(
            elevation: 0.3,
            color: _cardColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              child: Column(
                children: <Widget>[
                  IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (index) => Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        DateFormat.E()
                                            .format(
                                              DateTime.parse(weatherForecast
                                                  .weatherList[index].dtTxt),
                                            )
                                            .toUpperCase(),
                                      ),
                                      Container(
                                        height: 30.0,
                                        child: FlareActor(
                                          "assets/flare_animations/weather_icons/weather_${weatherForecast.weatherList[index].weatherIcon}.flr",
                                          fit: BoxFit.contain,
                                          animation:
                                              "${weatherForecast.weatherList[index].weatherIcon}",
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        DateFormat.jm()
                                            .format(getTime(
                                              weatherForecast
                                                  .weatherList[index].dt,
                                              weatherForecast
                                                  .weatherList[index].timeZone,
                                            ))
                                            .toString(),
                                        style: SmallTextStyle.apply(
                                          fontSizeFactor: 0.9,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                index < 4
                                    ? VerticalDivider(
                                        thickness: 1,
                                        color: Colors.white.withOpacity(0.3),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(0.0),
                                      )
                              ],
                            ),
                          ),
                        ).toList(),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: rotateAnimation.value,
                        child: child,
                      );
                    },
                    animation: rotateAnimation,
                    child: Container(
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.angleDown,
                          color: Colors.white30,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 500),
            height: _animatedHeight,
            child: AnimatedOpacity(
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 500),
              opacity: _animatedHeight == _animatedMaxHeight ? 1.0 : 0.0,
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
                            padding: const EdgeInsets.fromLTRB(
                                15.0, 15.0, 0.0, 15.0),
                            child: IntrinsicHeight(
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) => Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              SizedBox(height: 5.0),
                                              Text(
                                                "${weatherForecast.weatherList[index].temp} $temperatureUnit",
                                                style: SmallTextStyle.apply(
                                                  fontSizeFactor: 0.9,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        index < 4
                                            ? VerticalDivider(
                                                thickness: 1,
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.all(0.0),
                                              )
                                      ],
                                    ),
                                  ),
                                ).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: AspectRatio(
                          aspectRatio: 5 / 1.4, // width / height
                          child: LineChart(
                            mainData(weatherForecast.weatherList),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Code referred from flutter.dev
    /// See <https://api.flutter.dev/flutter/widgets/StreamBuilder-class.html> for source.
    return StreamBuilder(
        stream: weatherForecastBloc.weatherForecast,
        builder: (context, AsyncSnapshot<WeatherForecastModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.cod == "200") {
              return _buildWeatherForecastData(snapshot.data);
            } else {
              return Center(
                child: Text(snapshot.data.error.toUpperCase()),
              );
            }
          } else if (snapshot.hasError) {
            Fluttertoast.showToast(msg: snapshot.error);
            return Center(child: Text(snapshot.error));
          } else {
            return WeatherForecastLoading();
          }
        });
  }
}
