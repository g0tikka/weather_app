import 'dart:convert';

import 'package:weather_app/config.dart';
import 'package:weather_app/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather> getCurrentWeather(String cityname) async {
    final url =
        '${Config().baseUrl}/${Config().currentUrl}?key=${Config().apiKey}&q=$cityname';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('Request failed with status ${response.statusCode}');
      throw WeatherApiException('Error getting weather for $cityname');
    }

    final Map<String, dynamic> jsonResponse =
        Map.castFrom(jsonDecode(response.body));

    if (jsonResponse.isEmpty) {
      throw WeatherApiException('Weather data for $cityname not found');
    }

    return Weather.fromJson(jsonResponse);
  }

  Future<List<Forecast>> getWeeklyForecast(String cityname) async {
//http://api.weatherapi.com/v1/forecast.json?key=20c7c0d4422c4476873175527241502&q=London&days=7&aqi=no&alerts=no

    final url =
        '${Config().baseUrl}/${Config().forecastUrl}?key=${Config().apiKey}&q=$cityname&days=7';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print('Request failed with status ${response.statusCode}');
      throw WeatherApiException('Error getting forecast for $cityname');
    }

    final jsonResponse = jsonDecode(response.body);

    final forecastList = List<Map<String, dynamic>>.from(
        jsonResponse['forecast']['forecastday']);

    if (jsonResponse.isEmpty) {
      throw WeatherApiException('Forecast data for $cityname not found');
    }

    return forecastList
        .map((forecastData) => Forecast.fromJson(forecastData))
        .toList();
  }
}

class WeatherApiException implements Exception {
  final String message;

  const WeatherApiException(this.message);
}
