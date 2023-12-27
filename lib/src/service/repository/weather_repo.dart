import 'package:weather_app_assignment/src/service/api/weather_api.dart';
import 'package:weather_app_assignment/src/service/service.dart';

class WeatherRepo {
  static Future<Map<String, dynamic>> searchWeather(double lat, double long) {
    return APIService.instance.get(WeatherAPI.searchWeather, payload: {
      'latitude': lat,
      'longitude': long,
      'current': 'temperature_2m,wind_speed_10m',
      'hourly': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
    });
  }
}
