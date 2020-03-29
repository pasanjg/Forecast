import 'openweathermap_api_provider.dart';
import 'package:forecast/models/weather_model.dart';

class Repository {
  final openWeatherMapAPIProvider = OpenWeatherMapAPIProvider();

  Future<WeatherModel> fetchCurrentWeather(String requestURL) =>
      openWeatherMapAPIProvider.fetchCurrentWeather(requestURL);
}
