class WeatherModel {
  int _dt;
  String _dtTxt;
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
  int _sunRise;
  int _sunSet;
  int _timeZone;
  String _name;
  String _cod;
  String _error;

  WeatherModel();

  int get dt => _dt;

  set dt(int value) {
    _dt = value;
  }

  String get dtTxt => _dtTxt;

  set dtTxt(String value) {
    _dtTxt = value;
  }

  String get weatherMain => _weatherMain;

  set weatherMain(String value) {
    _weatherMain = value;
  }

  String get weatherDescription => _weatherDescription;

  set weatherDescription(String value) {
    _weatherDescription = value;
  }

  String get weatherIcon => _weatherIcon;

  set weatherIcon(String value) {
    _weatherIcon = value;
  }

  String get temp => _temp;

  set temp(String value) {
    _temp = value;
  }

  String get feelsLike => _feelsLike;

  set feelsLike(String value) {
    _feelsLike = value;
  }

  String get tempMin => _tempMin;

  set tempMin(String value) {
    _tempMin = value;
  }

  String get tempMax => _tempMax;

  set tempMax(String value) {
    _tempMax = value;
  }

  String get pressure => _pressure;

  set pressure(String value) {
    _pressure = value;
  }

  String get humidity => _humidity;

  set humidity(String value) {
    _humidity = value;
  }

  String get seaLevel => _seaLevel;

  set seaLevel(String value) {
    _seaLevel = value;
  }

  String get groundLevel => _groundLevel;

  set groundLevel(String value) {
    _groundLevel = value;
  }

  String get windSpeed => _windSpeed;

  set windSpeed(String value) {
    _windSpeed = value;
  }

  String get windDirection => _windDirection;

  set windDirection(String value) {
    _windDirection = value;
  }

  String get clouds => _clouds;

  set clouds(String value) {
    _clouds = value;
  }

  String get country => _country;

  set country(String value) {
    _country = value;
  }

  int get sunRise => _sunRise;

  set sunRise(int value) {
    _sunRise = value;
  }

  int get sunSet => _sunSet;

  set sunSet(int value) {
    _sunSet = value;
  }

  int get timeZone => _timeZone;

  set timeZone(int value) {
    _timeZone = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get cod => _cod;

  set cod(String value) {
    _cod = value;
  }

  String get error => _error;

  set error(String value) {
    _error = value;
  }

  WeatherModel.fromJSON(Map<String, dynamic> parsedJSON) {
    _dt = parsedJSON['dt'];
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
    _sunRise = parsedJSON['sys']['sunrise'];
    _sunSet = parsedJSON['sys']['sunset'];
    _timeZone = parsedJSON['timezone'];
    _name = parsedJSON['name'];
    _cod = parsedJSON['cod'].toString();
  }

  WeatherModel.fromError(String cod, String error) {
    _cod = cod;
    _error = error;
  }
}
