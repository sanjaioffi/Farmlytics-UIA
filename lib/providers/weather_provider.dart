import 'package:flutter/material.dart';
import 'package:uia_hackathon_app/functionalities/weather.dart';
import 'package:weather/weather.dart';

class WeatherProvider with ChangeNotifier {
  WeatherForecast weather = WeatherForecast();
  Weather? currentWeather;

  void updateWeather(lat, long) async {
    currentWeather = await weather.weather(lat, long);
    notifyListeners();
  }
}
