import 'dart:convert';

import 'package:codigo6_weatherapp/models/location_weather_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<LocationWeatherModel?> getWeatherData() async {
    Uri url = Uri.parse(
      "http://api.weatherapi.com/v1/current.json?key=719b5974828f49b29de03733230703&q=Trujillo&aqi=no",
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      LocationWeatherModel locationWeather =
          LocationWeatherModel.fromJson(data);
      //print(locationWeather);
      return locationWeather;
    }
    return null;
  }
}
