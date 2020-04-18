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
  int _timeZone;
  String _name;
  String _cod;
  String _error;

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

  int get timeZone => _timeZone;

  String get name => _name;

  String get cod => _cod;

  String get error => _error;

  WeatherModel.fromJSON(Map<String, dynamic> parsedJSON) {
//    print(parsedJSON.length);
//    print(parsedJSON['timezone']);
    _weatherMain = parsedJSON['weather'][0]['main'];
    _weatherDescription = parsedJSON['weather'][0]['description'];
    _weatherIcon = parsedJSON['weather'][0]['icon'];
    _temp = parsedJSON['main']['temp'].toString();
    _feelsLike = parsedJSON['main']['feels_like'].toString();
    _tempMin = parsedJSON['main']['temp_min'].toString();
    _tempMax = parsedJSON['main']['temp_max'].toString();
    _pressure = parsedJSON['main']['pressure'].toString();
    _humidity = parsedJSON['main']['humidity'].toString();
    _windSpeed = parsedJSON['wind']['speed'].toString();
    _clouds = parsedJSON['clouds']['all'].toString();
    _country = parsedJSON['sys']['country'];
    _sunRise = DateTime.parse(parsedJSON['sys']['sunrise'].toString());
    _sunSet = DateTime.parse(parsedJSON['sys']['sunset'].toString());
    _timeZone = parsedJSON['timezone'];
    _name = parsedJSON['name'];
    _cod = parsedJSON['cod'].toString();
  }

  WeatherModel.fromError(String cod, String error){
    _cod = cod;
    _error = error;
  }
}
