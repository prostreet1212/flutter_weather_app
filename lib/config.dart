class Config{
  Config._internal();
  static final Config _instance=Config._internal();

  factory Config()=>_instance;

  String apiKey='a37851ede1a9491295d70216240612';
  String baseUrl = 'http://api.weatherapi.com/v1';
  String currentUrl = 'current.json';
  String forecastUrl = 'forecast.json';
}