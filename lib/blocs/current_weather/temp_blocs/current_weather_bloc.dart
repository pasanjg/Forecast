//import 'dart:async';
//import 'package:bloc_provider/bloc_provider.dart';
//import 'package:forecast/models/weather_model.dart';
//import 'package:rxdart/rxdart.dart';
//import 'package:forecast/resources/repository.dart';
//
//class CurrentWeatherBloc implements Bloc {
//  final _repository = Repository();
//
//  final _requestURL = PublishSubject<String>(); // putting data
//  Function(String) get fetchCurrentWeatherByURL => _requestURL.sink.add;
//
//  final _currentWeather = BehaviorSubject<Future<WeatherModel>>(); // stream
//  Stream<Future<WeatherModel>> get currentWeather => _currentWeather.stream;
//
//  CurrentWeatherBloc() {
//    _requestURL.stream.transform(_weatherTransformer()).pipe(_currentWeather);
//  }
//
//  _weatherTransformer() {
//    return ScanStreamTransformer(
//      (Future<WeatherModel> weather, String requestURL, int index) {
//        weather = _repository.fetchCurrentWeather(requestURL);
//        print(weather);
//        return weather;
//      },
//    );
//  }
//
//  dispose() async {
//    await _requestURL.close();
//    await _currentWeather.drain();
//  }
//}
