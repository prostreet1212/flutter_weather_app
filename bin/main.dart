import 'dart:io';

import 'package:flutter_weather_app/weather_api_client.dart';

void main(List<String> arguments) async {
  if (arguments.length != 1) {
    print('Syntax error: dart <city>');
    return;
  }

  final cityName = arguments.first;
  //print(cityName);

  final weatherApiClient = WeatherApiClient();

  //Получение текущей погоды
  try {
    final currentWeather = await weatherApiClient.getCurrentWeather(cityName);
    print('Current weather for $cityName');
    print(currentWeather);
    print('----------------------------\n');
  } on WeatherApiException catch (error) {
    print('Error ${error.message}');
  } on SocketException catch (_) {
    print(
        'Could not fetch current weather data. Check your internet connection!');
  } catch (e) {
    print(e);
  }

  //Получение прогноза погоды на неделю
  try {
    final weeklyForecast = await weatherApiClient.getWeeklyForecast(cityName);
    print('Weekly forecast for $cityName');
    weeklyForecast.forEach((forecast) {
      print(forecast);
      print('----------------------------\n');
    });
  } on WeatherApiException catch (error) {
    print('Error ${error.message}');
  } on SocketException catch (_) {
    print(
        'Could not fetch forecast data. Check your internet connection!');
  } catch (e) {
    print(e);
  }
}
