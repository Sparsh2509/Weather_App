class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;
  final double feelsLike;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.feelsLike,
  });

}