import 'dart:async';
import 'package:forecast/models/weather_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:forecast/resources/repository.dart';

/// Code for BLoC Pattern referred from a Medium post.
/// See <https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1> for source.
class CurrentWeatherBloc {
  final _repository = Repository();
  PublishSubject<WeatherModel> _currentWeatherFetcher =
      PublishSubject<WeatherModel>();

  Stream<WeatherModel> get currentWeather {
    if (_currentWeatherFetcher.isClosed) {
      _currentWeatherFetcher = PublishSubject<WeatherModel>();
    }
    return _currentWeatherFetcher.stream;
  }

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
