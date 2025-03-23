import 'package:flutter/material.dart';
import 'package:weather_app/Constants/colors.dart';
import 'package:weather_app/Constants/dark_mode.dart';
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

  void _fetchWeather() async {
    FocusScope.of(context).unfocus();

     if (_cityController.text.trim().isEmpty) {
      setState(() {
      _weather = null; // Clear previous data
    });
       _showSnackBar("Please enter a city name", redColor);
     
      return;
    } // Hide keyboard
    setState(() {
      _isLoading = true;
      _weather = null ;
    });

    try {
    final weather = await _weatherService.fetchWeather(_cityController.text.trim());
    if (weather == null) {
        throw Exception("No city found");
      } 
    setState(() {
      _weather = weather;
      _isLoading = false;
      // _cityController.clear(); // Clear input field
    });
  } catch (e) {
    setState(() {
      
      _isLoading = false;
      _weather = null ;
    });
     _showSnackBar(e.toString().contains("No city found") ? "No city found" : "Error fetching weather", redColor);
    
  }
  

  }
    void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
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
              colors: isDarkMode
                  ? [darkGradientColor_1, darkGradientColor_2]
                  : [lightGradientColor_1, lighGradientColor_2],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenHeight * 0.02, vertical: screenWidth * 0.02),
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
                        color: isDarkMode ? whiteColor : blackColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: isDarkMode ? whiteColor : blackColor,
                          size: 30),
                      onPressed: toggleDarkMode,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    hintText: "Enter city name",
                    hintStyle:
                        TextStyle(color: isDarkMode ? whiteColor : blackColor),
                    filled: true,
                    fillColor: isDarkMode ? greyColor[800] : Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: isDarkMode ? greyColor : blackColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: isDarkMode ? greyColor : blueColor, width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
                          color: isDarkMode ? whiteColor : blackColor),
                      onPressed: _fetchWeather,
                    ),
                  ),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? whiteColor : blackColor),
                ),
                SizedBox(height: screenHeight * 0.03),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                isDarkMode ? whiteColor : blackColor)))
                    : _weather != null
                        ? Flexible(
                            child: SingleChildScrollView(
                              child: WeatherCard(weather: _weather!),
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
