import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _isDarkMode 
                ? [Colors.black87, Colors.black54] 
                : [Colors.blueAccent, Colors.lightBlueAccent],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Weather App",
                    style: TextStyle(
                      fontSize: 28, 
                      fontWeight: FontWeight.bold, 
                      color: _isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: _isDarkMode ? Colors.white : Colors.black,
                        size: 30),
                    onPressed: _toggleTheme,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  hintText: "Enter city name",
                  filled: true,
                  fillColor: _isDarkMode ? Colors.grey[800] : Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: _isDarkMode ? Colors.white : Colors.black),
                    onPressed: _fetchWeather,
                  ),
                ),
                style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              _isLoading
                  ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(_isDarkMode ? Colors.white : Colors.blue)))
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
    );
  }
}