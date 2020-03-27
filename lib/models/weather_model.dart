class WeatherModel {
  String _weatherMain;
  String _weatherDescription;
  String _weatherIcon;
  String _temp;
  String _feelsLike;
  String _tempMin;
  String _tempMax;
  String _pressure;
  String _humidity;
  String _seaLevel;
  String _groundLevel;
  String _windSpeed;
  String _windDirection;
  String _clouds;
  String _country;
  DateTime _sunRise;
  DateTime _sunSet;
  String _name;
  String _cod;

  String get weatherMain => _weatherMain;

  String get weatherDescription => _weatherDescription;

  String get weatherIcon => _weatherIcon;

  String get temp => _temp;

  String get feelsLike => _feelsLike;

  String get tempMin => _tempMin;

  String get tempMax => _tempMax;

  String get pressure => _pressure;

  String get humidity => _humidity;

  String get seaLevel => _seaLevel;

  String get groundLevel => _groundLevel;

  String get windSpeed => _windSpeed;

  String get windDirection => _windDirection;

  String get clouds => _clouds;

  String get country => _country;

  DateTime get sunRise => _sunRise;

  DateTime get sunSet => _sunSet;

  String get name => _name;

  String get cod => _cod;

  WeatherModel.fromJSON(Map<String, dynamic> parsedJSON) {
    print(parsedJSON);
  }
}
