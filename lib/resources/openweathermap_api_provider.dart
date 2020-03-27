import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:forecast/models/weather_model.dart';
import 'package:forecast/models/openweathermap_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherMapAPIProvider {
  var client = http.Client();
  final apiKey = DotEnv().env['OPENWEATHERMAP_API_KEY'];
  final apiBaseURL = DotEnv().env['OPENWEATHERMAP_API_BASE_URL'];

  Future<WeatherModel> fetchCurrentWeather(
      OpenWeatherMapAPI openWeatherMapAPI) async {
    final response = await client.get(openWeatherMapAPI.requestURL);
    if (response.statusCode == 200) {
      return WeatherModel.fromJSON(json.decode(response.body));
    } else {
      throw Exception("Failed to load data :(");
    }
  }
}
