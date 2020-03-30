import 'package:flutter/material.dart';
import 'package:forecast/models/openweathermap_api.dart';
import 'package:intl/intl.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/blocs/current_weather/current_weather_bloc.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CurrentWeatherDetailsPage extends StatefulWidget {
  @override
  _CurrentWeatherDetailsPageState createState() =>
      _CurrentWeatherDetailsPageState();
}

class _CurrentWeatherDetailsPageState extends State<CurrentWeatherDetailsPage> {
  OpenWeatherMapAPI openWeatherMapAPI;

  @override
  void initState() {
    super.initState();
    openWeatherMapAPI = OpenWeatherMapAPI(cityName: "Malabe", units: "metric");
    currentWeatherBloc.fetchCurrentWeather(openWeatherMapAPI.requestURL);
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

  Widget _buildCurrentWeatherData(WeatherModel currentWeather) {
    Color _cardColor = Theme.of(context).primaryColor.withOpacity(0.8);
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
                  currentWeather.name.toUpperCase(),
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
                            "assets/flare_animations/weather_icons/weather_${currentWeather.weatherIcon}.flr",
                            fit: BoxFit.contain,
                            animation: currentWeather.weatherIcon,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: <Widget>[
                        Text(
                          "${currentWeather.temp}°C",
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 50.0,
                          ),
                        ),
                        Text(
                          currentWeather.weatherDescription.toUpperCase(),
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "${currentWeather.feelsLike}°C",
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
                                  "${currentWeather.tempMax}°C",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                  ),
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
                                  "${currentWeather.tempMin}°C",
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
                                  "${currentWeather.pressure} hPa",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0),
                                ),
                                Text(
                                  "Pressure",
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
                                  "${currentWeather.humidity}%",
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
                                    "assets/flare_animations/weather_icons/weather_02d.flr",
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
                                    "assets/flare_animations/weather_icons/weather_11d.flr",
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
                                    "assets/flare_animations/weather_icons/weather_04d.flr",
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
                                    "assets/flare_animations/weather_icons/weather_09d.flr",
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
                                    "assets/flare_animations/weather_icons/weather_50d.flr",
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

  @override
  Widget build(BuildContext context) {
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
