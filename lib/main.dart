import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/Constants/dark_mode.dart';
import 'package:weather_app/Constants/size.dart';
import 'package:weather_app/Pages/Homepage.dart';
import 'package:weather_app/Pages/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color(0xff000000)
      ),
      routes: {
         "/" :(context) => SplashScreen(),
        "/home" : (context) => HomeScreen(),
        

      },

    );

      
        
    
  }
}


 
