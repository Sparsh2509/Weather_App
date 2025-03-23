import 'package:flutter/material.dart';
import 'package:weather_app/Constants/dark_mode.dart';
import 'package:weather_app/Constants/size.dart';
import 'package:weather_app/Models/Weather_model.dart';



class WeatherCard extends StatelessWidget {
  final WeatherModel weather;


  WeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      color: isDarkMode ? Colors.grey[900] : Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 10),
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}.png",
              width: 80,
              height: 80,
            ),
            Text(
              "${weather.temperature}°C",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
            ),
            Text(weather.description, style: TextStyle(fontSize: 18, color: isDarkMode ? Colors.white70 : Colors.black87)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _weatherDetailItem(Icons.water_drop, "Humidity", "${weather.humidity}%", Colors.blue, isDarkMode),
                _weatherDetailItem(Icons.air, "Wind", "${weather.windSpeed} m/s", Colors.blueGrey, isDarkMode),
                _weatherDetailItem(Icons.thermostat, "Feels Like", "${weather.feelsLike}°C", Colors.redAccent, isDarkMode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherDetailItem(IconData icon, String label, String value, Color iconColor, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white70 : Colors.black87)),
          SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black)),
          SizedBox( height: screenHeight*0.01,)
        ],
      ),
    );
  }
}
