import 'dart:async';
import 'package:forecast/models/weather_forecast_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:forecast/resources/repository.dart';

class WeatherForecastBloc {
  final _repository = Repository();
  PublishSubject<WeatherForecastModel> _weatherForecastFetcher =
      PublishSubject<WeatherForecastModel>();

  Stream<WeatherForecastModel> get weatherForecast {
    if (_weatherForecastFetcher.isClosed) {
      _weatherForecastFetcher = PublishSubject<WeatherForecastModel>();
    }
    return _weatherForecastFetcher.stream;
  }

  fetchWeatherForecast(String requestURL) async {
    WeatherForecastModel weatherForecastModel =
        await _repository.fetchWeatherForecast(requestURL);
    _weatherForecastFetcher.sink.add(weatherForecastModel);
  }

  dispose() async {
    _weatherForecastFetcher.close();
  }
}

final weatherForecastBloc = WeatherForecastBloc();
