import 'dart:convert';

import 'package:flutter_weather_app/config.dart';
import 'package:flutter_weather_app/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {

  Future<Weather> getCurrentWeather(String cityName) async {
    //https://api.weatherapi.com/v1/current.json?key=a37851ede1a9491295d70216240612&q=London&aqi=no
    final url =
        '${Config().baseUrl}/${Config().currentUrl}?key=${Config().apiKey}&q=$cityName}';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print('Request failed with status ${response.statusCode}');
      throw WeatherApiException('Error getting weather for $cityName');
    }
    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));
    if (jsonResponse.isEmpty) {
      throw WeatherApiException('Weather data for $cityName not found');
    }
    return Weather.fromJson(jsonResponse);
  }


  Future<List<Forecast>> getWeeklyForecast(String cityName) async {
    https://api.weatherapi.com/v1/forecast.json?key=a37851ede1a9491295d70216240612&q=London&days=7&aqi=no&alerts=no
    final url =
        '${Config().baseUrl}/${Config().forecastUrl}?key=${Config().apiKey}&q=$cityName&days=7';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print('Request failed with status ${response.statusCode}');
      throw WeatherApiException('Error getting forecast for $cityName');
    }
    final jsonResponse = jsonDecode(response.body);
    List<Map<String,dynamic>> forecastList=List<Map<String,dynamic>>
        .from(jsonResponse['forecast']['forecastday']);
    if (jsonResponse.isEmpty) {
      throw WeatherApiException('Forecast data for $cityName not found');
    }
    return forecastList.map((forecastData)=>Forecast.fromJson(forecastData)).toList();
  }
}

class WeatherApiException implements Exception{
final message;
const WeatherApiException(this.message);
}