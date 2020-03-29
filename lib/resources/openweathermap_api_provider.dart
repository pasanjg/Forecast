import 'package:forecast/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherMapAPIProvider {
  var client = http.Client();

  Future<WeatherModel> fetchCurrentWeather(String requestURL) async {
    final response = await client.get(requestURL);
    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      return WeatherModel.fromJSON(jsonResponse);
    } else {
      print(jsonResponse['message']);
      throw Exception("Failed to load data :(");
    }
  }
}
