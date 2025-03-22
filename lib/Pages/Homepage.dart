import 'package:flutter/material.dart';
import 'package:weather_app/Constants/colors.dart';
import 'package:weather_app/Constants/size.dart';
import 'package:weather_app/Constants/weather_card.dart';
import 'package:weather_app/Models/Weather_model.dart';
import 'package:weather_app/Services/get_services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  bool _isLoading = false;
  bool _isDarkMode = true;

  void _fetchWeather() async {
    FocusScope.of(context).unfocus(); // Hide keyboard
    setState(() {
      _isLoading = true;
    });
    
    final weather = await _weatherService.fetchWeather(_cityController.text);
    
    setState(() {
      _weather = weather;
      _isLoading = false;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _isDarkMode 
                  ? [darkGradientColor_1, darkGradientColor_2] 
                  : [lightGradientColor_1, lighGradientColor_2],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight *0.02, vertical: screenWidth*0.02),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Weather App",
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: _isDarkMode ? whiteColor : blackColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: _isDarkMode ? whiteColor : blackColor,
                          size: 30),
                      onPressed: _toggleTheme,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  controller: _cityController,                  
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    hintStyle: TextStyle( color:_isDarkMode? whiteColor : blackColor),
                    filled: true,
                    fillColor: _isDarkMode ? greyColor[800] : Colors.white,
                     enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _isDarkMode ? greyColor : blackColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: _isDarkMode ? greyColor : splashColor, width: 2),
                  ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search, color: _isDarkMode ? whiteColor : blackColor),
                      onPressed: _fetchWeather,
                    ),
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold ,color: _isDarkMode ? whiteColor : blackColor),
                ),
                SizedBox(height: screenHeight * 0.03),
                _isLoading
                    ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(_isDarkMode ? whiteColor : blackColor)))
                    : _weather != null
                        ? Flexible(
                            child: SingleChildScrollView(
                              child: WeatherCard(weather: _weather!, isDarkMode: _isDarkMode),
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}