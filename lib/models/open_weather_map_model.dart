import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenWeatherMapAPI {
  final String apiKey = DotEnv().env['OPENWEATHERMAP_API_KEY'];
  final String apiBaseURL = DotEnv().env['OPENWEATHERMAP_API_BASE_URL'];
  final String cityName;
  final String cityId;
  final Map coordinates;
  final String zipCode;
  final String units;
  final bool forecast;

  String _requestURL;

  String get requestURL => _requestURL;

  // cityName = https://api.openweathermap.org/data/2.5/weather?q=Malabe&appid=0966efbf0506aeb829958876034e452e&units=metric
  // coordinates = http://api.openweathermap.org/data/2.5/weather?lat=6.9&lon=79.95&appid=0966efbf0506aeb829958876034e452e&units=metric

  OpenWeatherMapAPI(
      {this.cityName,
      this.cityId,
      this.coordinates,
      this.zipCode,
      this.units,
      this.forecast = false})
      : assert(
            cityName == null ||
                cityId == null ||
                coordinates == null ||
                zipCode == null,
            'Cannot search with all parameters.') {
    String weatherType = this.forecast ? "forecast" : "weather";

    this.cityName != null
        ? this._requestURL =
            "$apiBaseURL/$weatherType?q=$cityName&appid=$apiKey&units=$units"
        : cityId != null
            ? this._requestURL =
                "$apiBaseURL/$weatherType?id=$cityId&appid=$apiKey&units=$units"
            : coordinates != null
                ? this._requestURL =
                    "$apiBaseURL/$weatherType?lat=${coordinates['lat']}&lon=${coordinates['lon']}&appid=$apiKey&units=$units"
                : this._requestURL =
                    "$apiBaseURL/$weatherType?zip=$zipCode&appid=$apiKey&units=$units";

    print(requestURL);
  }
}

/*

class CurrentWeather{

  CurrentWeather.fromResponse();
}

class WeatherForecast{

  WeatherForecast.fromResponse();
}

*/
