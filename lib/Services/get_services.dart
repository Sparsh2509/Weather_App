import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/Models/Weather_model.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeather(String cityName) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=5d70bc60229315ee65eff569b57f6d8b&units=metric'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel(
          cityName: data["name"],
          temperature: data["main"]["temp"].toDouble(),
          description: data["weather"][0]["description"],
          icon: data["weather"][0]["icon"],
          humidity: data["main"]["humidity"],
          windSpeed: data["wind"]["speed"].toDouble(),
          feelsLike: data["main"]["feels_like"].toDouble(),
        );
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}