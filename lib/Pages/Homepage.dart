

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/Constants/colors.dart';
import 'dart:convert';

import 'package:weather_app/Constants/size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final SearchController _searchController = SearchController();
    String _weatherInfo = "Enter a location to get weather";

    Future<void> fetchWeather(String location) async {
     try{
      Response response = await get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$location&appid=5d70bc60229315ee65eff569b57f6d8b&units=metric"));
       var data = jsonDecode(response.body.toString());
       print(data);
      
      if (data["cod"] == 200){
        setState(() {
          _weatherInfo = data["main"]["temp"].toString();
          print(_weatherInfo);
        });
      }

      else {
        setState(() {
          _weatherInfo = "Location not found!";
        });
      }


     }
     catch(e){
      setState(() {
        _weatherInfo = "Error fetching weather";
      });
     }
     
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(title: Text("Weather App")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          
          children: [
            SizedBox(
              height: screenHeight*0.02
            ),
            TextFormField(
              style: TextStyle(color: whiteColor),
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Enter Location",
                hintStyle: TextStyle(color: whiteColor),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: whiteColor,),
                  onPressed: () {
                    fetchWeather(_searchController.text);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
               Text(
                  _weatherInfo,
                  style: TextStyle(fontSize: 18,color: whiteColor),
                  textAlign: TextAlign.center,
                ),
          ],
        ),
      ),
    )
      );
  }
}
