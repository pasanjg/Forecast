import 'package:forecast/models/weather_forecast_model.dart';

import 'openweathermap_api_provider.dart';
import 'package:forecast/models/weather_model.dart';

class Repository {
  final openWeatherMapAPIProvider = OpenWeatherMapAPIProvider();

  Future<WeatherModel> fetchCurrentWeather(String requestURL) =>
      openWeatherMapAPIProvider.fetchCurrentWeather(requestURL);

  Future<WeatherForecastModel> fetchWeatherForecast(String requestURL) =>
      openWeatherMapAPIProvider.fetchWeatherForecast(requestURL);
}
