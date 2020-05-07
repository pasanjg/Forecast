import 'package:forecast/models/weather_forecast_model.dart';

import 'openweathermap_api_provider.dart';
import 'package:forecast/models/weather_model.dart';

/// Code for BLoC Pattern referred from a Medium post.
/// See <https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1> for source.
class Repository {
  final openWeatherMapAPIProvider = OpenWeatherMapAPIProvider();

  Future<WeatherModel> fetchCurrentWeather(String requestURL) =>
      openWeatherMapAPIProvider.fetchCurrentWeather(requestURL);

  Future<WeatherForecastModel> fetchWeatherForecast(String requestURL) =>
      openWeatherMapAPIProvider.fetchWeatherForecast(requestURL);
}
