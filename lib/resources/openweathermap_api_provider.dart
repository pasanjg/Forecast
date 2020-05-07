import 'package:forecast/models/weather_forecast_model.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Code for BLoC Pattern referred from a Medium post.
/// See <https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1> for source.
class OpenWeatherMapAPIProvider {
  var client = http.Client();

  Future<WeatherModel> fetchCurrentWeather(String requestURL) async {
    try {
      final response = await client.get(requestURL);
      final jsonResponse = json.decode(response.body);

      print("STATUS: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        return WeatherModel.fromJSON(jsonResponse);
      } else {
        return WeatherModel.fromError(
            response.statusCode.toString(), jsonResponse['message']);
      }
    } catch (e) {
      throw Exception("Failed to load current weather data :(");
    }
  }

  Future<WeatherForecastModel> fetchWeatherForecast(String requestURL) async {
    try {
      final response = await client.get(requestURL);
      final jsonResponse = json.decode(response.body);

      print("STATUS: " + response.statusCode.toString());
      if (response.statusCode == 200) {
        return WeatherForecastModel.fromJSON(jsonResponse);
      } else {
        print(jsonResponse['message']);
        return WeatherForecastModel.fromError(
            response.statusCode.toString(), jsonResponse['message']);
      }
    } catch (e) {
      throw Exception("Failed to load weather forecast data :(");
    }
  }
}
