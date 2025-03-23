import 'package:flutter/material.dart';
import 'package:weather_app/Constants/colors.dart';
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
      color: isDarkMode ? greyColor[900] : whiteColor.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.cityName,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? whiteColor : blackColor),
            ),
            SizedBox(height: 10),
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}.png",
              height: screenHeight * 0.08,
            ),
            Text(
              "${weather.temperature}°C",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? whiteColor : blackColor),
            ),
            Text(weather.description,
                style: TextStyle(
                    fontSize: 18, color: isDarkMode ? whiteColor : blackColor)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _weatherDetailItem(Icons.water_drop, "Humidity",
                    "${weather.humidity}%", blueColor, isDarkMode),
                _weatherDetailItem(Icons.air, "Wind",
                    "${weather.windSpeed} m/s", blueGreyColor, isDarkMode),
                _weatherDetailItem(Icons.thermostat, "Feels Like",
                    "${weather.feelsLike}°C", redColor, isDarkMode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherDetailItem(IconData icon, String label, String value,
      Color iconColor, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode ? greyColor[850] : brownColor[200]?.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          SizedBox(height: screenHeight * 0.01),
          Text(label,
              style: TextStyle(
                  fontSize: 14, color: isDarkMode ? whiteColor : blackColor)),
          SizedBox(height: screenHeight * 0.01),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? whiteColor : blackColor)),
          SizedBox(height: screenHeight * 0.01)
        ],
      ),
    );
  }
}
