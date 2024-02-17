class Config {
  Config._internal();

  static final Config _instance = Config._internal();

  factory Config() => _instance;

  String apiKey = '20c7c0d4422c4476873175527241502';

  String baseUrl = 'http://api.weatherapi.com/v1';
  String currentUrl = 'current.json';
  String forecastUrl = 'forecast.json';
}
