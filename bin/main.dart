import 'dart:io';

import 'package:weather_app/weather_api_client.dart';

void main(List<String> arguments) async {
  if (arguments.length != 1) {
    print('Syntax error. dart bin/main.dart <city>');
    return;
  }

  final cityname = arguments.first;

  final weatherapiClient = WeatherApiClient();
//Getting current weather
  try {
    final currentWeather = await weatherapiClient.getCurrentWeather(cityname);
    print('Current weather for $cityname:');
    print(currentWeather);
  } on WeatherApiException catch (e) {
    print('Error: ${e.message}');
  } on SocketException catch (_) {
    print(
        'Could not fetch current weather data. Check your internet connection.');
  } catch (e) {
    print(e);
  }

//Week forecast
  try {
    final weeklyForecast = await weatherapiClient.getWeeklyForecast(cityname);
    print('Weekly forecast for $cityname:');
    for (var forecast in weeklyForecast) {
      print(forecast);
    }
  } on WeatherApiException catch (e) {
    print('Error: ${e.message}');
  } on SocketException catch (_) {
    print('Could not fetch forecast data. Check your internet connection.');
  } catch (e) {
    print(e);
  }
}
