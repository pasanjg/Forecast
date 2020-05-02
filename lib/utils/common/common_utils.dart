import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

String getTemperatureUnit(String units) {
  return units == null
      ? "K"
      : units == "imperial" ? "°F" : units == "metric" ? "°C" : "K";
}

String getTemperatureValue(String units) {
  return units == null
      ? "Kelvin"
      : units == "imperial"
          ? "Fahrenheit"
          : units == "metric" ? "Celsius" : "Kelvin";
}

String getTemperatureAPIUnit(String units) {
  String value = units == "Kelvin"
      ? null
      : units == "Fahrenheit"
          ? "imperial"
          : units == "Celsius" ? "metric" : null;
  return value;
}

String getTime(int seconds, int timeZone) {
  String time;
  DateTime dateTime =
  DateTime.fromMillisecondsSinceEpoch(seconds * 1000).toUtc();

  if (timeZone >= 0) {
    dateTime = dateTime.add(
      Duration(
        hours: DateFormat("ss").parse(timeZone.toString()).hour,
        minutes: DateFormat("ss").parse(timeZone.toString()).minute,
      ),
    );
  } else {
    timeZone *= -1;
    dateTime = dateTime.subtract(
      Duration(
        hours: DateFormat("ss").parse(timeZone.toString()).hour,
        minutes: DateFormat("ss").parse(timeZone.toString()).minute,
      ),
    );
  }

  time = DateFormat.jm().format(dateTime);
  return time.toString();
}

void showFlutterToast(String message, {bool isLong = false}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black87,
    toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    textColor: Colors.white,
  );
}
