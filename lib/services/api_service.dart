import 'dart:convert';

import 'package:codigo6_weatherapp/models/location_weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<LocationWeatherModel?> getWeatherData(String cityName) async {
    Uri url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=719b5974828f49b29de03733230703&q=$cityName&aqi=no",
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      LocationWeatherModel locationWeather =
          LocationWeatherModel.fromJson(data);
      return locationWeather;
    }
    return null;
  }

  Future<LocationWeatherModel?> getWeatherLocation(
      double latitude, double longitude) async {
    Uri url = Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=719b5974828f49b29de03733230703&q=$latitude,$longitude&aqi=no",
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      LocationWeatherModel locationWeather =
          LocationWeatherModel.fromJson(data);
      return locationWeather;
    }
    return null;
  }
}
