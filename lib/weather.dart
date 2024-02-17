class Weather {
  final String lastUpdated;
  final String cityName;
  final double tempC;
  final double feelsLikeC;
  final String condition;

  Weather(
      {required this.lastUpdated,
      required this.cityName,
      required this.tempC,
      required this.feelsLikeC,
      required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final city = json['location'];
    return Weather(
        lastUpdated: current['last_updated'],
        cityName: city['name'],
        tempC: current['temp_c'],
        feelsLikeC: current['feelslike_c'],
        condition: current['condition']['text']);
  }

  @override
  String toString() => '''
Last updated: $lastUpdated
City name: $cityName
Temperature: $tempC
Feels like: $feelsLikeC
Weather condition: $condition
 ''';
}

class Forecast {
  final String date;
  final double minTempC;
  final double maxTempC;
  final String condition;

  Forecast(
      {required this.date,
      required this.minTempC,
      required this.maxTempC,
      required this.condition});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final conditionData = json['day']['condition'];
    return Forecast(
      date: json["date"],
      minTempC: json['day']['mintemp_c'],
      maxTempC: json['day']['maxtemp_c'],
      condition: conditionData['text'],
    );
  }

  @override
  String toString() => ''' 
  Date: $date
  Min temperature: $minTempC
  Max temperature: $maxTempC
  Weather condition: $condition
  ''';
}
