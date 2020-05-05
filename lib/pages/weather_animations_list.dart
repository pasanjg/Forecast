import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class WeatherAnimationsPage extends StatefulWidget {
  @override
  _WeatherAnimationsPageState createState() => _WeatherAnimationsPageState();
}

class _WeatherAnimationsPageState extends State<WeatherAnimationsPage> {
  Widget _weatherItem(
    BuildContext context,
    String weatherIcon,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 0.2,
        color: Theme.of(context).accentColor.withAlpha(80),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 50.0,
                  child: FlareActor(
                    "assets/flare_animations/weather_icons/weather_${weatherIcon}d.flr",
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: "${weatherIcon}d",
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 50.0,
                  child: FlareActor(
                    "assets/flare_animations/weather_icons/weather_${weatherIcon}n.flr",
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: "${weatherIcon}n",
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: SmallTextStyle.apply(fontSizeFactor: 1.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        centerTitle: true,
        title: Text("Weather Animations"),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (scroll) {
          scroll.disallowGlow();
          return true;
        },
        child: DefaultGradient(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Day Icon",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Night Icon",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Description",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView(
                    children: <Widget>[
                      _weatherItem(context, "01", "Clear sky"),
                      _weatherItem(context, "02", "Few clouds"),
                      _weatherItem(context, "03", "Scattered clouds"),
                      _weatherItem(context, "04", "Broken clouds"),
                      _weatherItem(context, "09", "Shower rain"),
                      _weatherItem(context, "10", "Rain"),
                      _weatherItem(context, "11", "Thunderstorm"),
                      _weatherItem(context, "13", "Snow"),
                      _weatherItem(context, "50", "Mist"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
