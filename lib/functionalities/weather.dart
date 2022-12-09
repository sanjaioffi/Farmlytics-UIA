import 'package:weather/weather.dart';

class WeatherForecast {
  Future<Weather> weather(_lat, _long) async {
    double lat = _lat;
    double long = _long;
    String key = '6e4e64dad91138759bae039ce4798e6d';
    WeatherFactory wf = WeatherFactory(key);
    Weather w = await wf.currentWeatherByLocation(lat, long);
    return w;
  }
}
