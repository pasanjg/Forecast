import 'package:forecast/models/weather_model.dart';

class WeatherForecastModel {
  String _cod;
  int _cnt;
  List<WeatherModel> _weatherList;
  String _country;
  String _name;
  int _timeZone;
  String _error;

  String get cod => _cod;

  int get cnt => _cnt;

  List<WeatherModel> get weatherList => _weatherList;

  String get country => _country;

  String get name => _name;

  int get timeZone => _timeZone;

  String get error => _error;

  WeatherForecastModel.fromJSON(Map<String, dynamic> parsedJSON) {
    _cod = parsedJSON['cod'].toString();
    _cnt = parsedJSON['cnt'];
    _timeZone = parsedJSON['city']['timezone'];
    _weatherList = List();

    for (int i = 0; i < 39; i += 7) {
      WeatherModel weatherModel = WeatherModel();
      weatherModel.dt = parsedJSON['list'][i]['dt'];
      weatherModel.dtTxt = parsedJSON['list'][i]['dt_txt'];
      weatherModel.temp = parsedJSON['list'][i]['main']['temp'].toString();
      weatherModel.weatherIcon = parsedJSON['list'][i]['weather'][0]['icon'];
      weatherModel.timeZone = _timeZone;
      _weatherList.add(weatherModel);
    }
  }

  WeatherForecastModel.fromError(String cod, String error) {
    _cod = cod;
    _error = error;
  }
}
