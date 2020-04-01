import 'dart:async';
import 'package:forecast/models/weather_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:forecast/resources/repository.dart';

class CurrentWeatherBloc {
  final _repository = Repository();
  final _currentWeatherFetcher = PublishSubject<WeatherModel>();

  Stream<WeatherModel> get currentWeather => _currentWeatherFetcher.stream;

  fetchCurrentWeather(String requestURL) async {
    WeatherModel weatherModel =
        await _repository.fetchCurrentWeather(requestURL);
    _currentWeatherFetcher.sink.add(weatherModel);
  }

  dispose() async {
    _currentWeatherFetcher.close();
  }
}

final currentWeatherBloc = CurrentWeatherBloc();