import 'dart:math';

/// OpenWeatherMapAPI Model Class

class OpenWeatherMapAPI {
  final List<String> apiKeysList = [
    "0966efbf0506aeb829958876034e452e",
    "08fab3f85391d043dfd9f170cfc6786c",
    "1353fafb98e1fb4f06bca43498c59ba2",
    "883791bb395ad3f944ff6ddce0fba094",
    "93774eede4efd4cb3232ca75f082917e",
  ];
  final String apiBaseURL = "https://api.openweathermap.org/data/2.5";
  final String cityName;
  final String cityId;
  final Map coordinates;
  final String zipCode;
  final String units;
  final bool forecast;
  String _requestURL;

  String get requestURL => _requestURL;

  String get apiKey {
    var random = new Random();
    print(random.nextInt(apiKeysList.length));
    return apiKeysList[random.nextInt(apiKeysList.length)];
  }

  /// Sample API call.
  /// cityName = https://api.openweathermap.org/data/2.5/weather?q=Malabe,LK&appid=0966efbf0506aeb5829958876034e452e&units=metric
  /// coordinates = http://api.openweathermap.org/data/2.5/weather?lat=6.9&lon=79.95&appid=0966efbf0506aeb8299558876034e452e&units=metric

  /// List of all API parameters with units <openweathermap.org/weather-data>

  OpenWeatherMapAPI(
      {this.cityName,
      this.cityId,
      this.coordinates,
      this.zipCode,
      this.units,
      this.forecast = false})
      : assert(
            cityName == null ||
                cityId == null ||
                coordinates == null ||
                zipCode == null,
            'Cannot search with all parameters.') {
    String weatherType = this.forecast ? "forecast" : "weather";

    this.cityName != null
        ? this._requestURL =
            "$apiBaseURL/$weatherType?q=$cityName&appid=$apiKey&units=$units"
        : cityId != null
            ? this._requestURL =
                "$apiBaseURL/$weatherType?id=$cityId&appid=$apiKey&units=$units"
            : coordinates != null
                ? this._requestURL =
                    "$apiBaseURL/$weatherType?lat=${coordinates['lat']}&lon=${coordinates['lon']}&appid=$apiKey&units=$units"
                : this._requestURL =
                    "$apiBaseURL/$weatherType?zip=$zipCode&appid=$apiKey&units=$units";

    print(requestURL);
  }
}
