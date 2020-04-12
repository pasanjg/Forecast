class CommonUtils {
  static String getTemperatureUnit(String units) {
    return units == null
        ? "K"
        : units == "imperial" ? "°F" : units == "metric" ? "°C" : "K";
  }

  static String getTemperatureValue(String units) {
    return units == null
        ? "Kelvin"
        : units == "imperial"
            ? "Fahrenheit"
            : units == "metric" ? "Celsius" : "Kelvin";
  }

  static String getTemperatureAPIUnit(String units) {
    String value = units == "Kelvin"
        ? "standard"
        : units == "Fahrenheit"
        ? "imperial"
        : units == "Celsius" ? "metric" : "standard";
    return value;
  }
}
