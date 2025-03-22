import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Constants/colors.dart';
import 'package:weather_app/Constants/size.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: splashColor,
      

        body:
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash_screen.gif', width: 150, height: 150),
            SizedBox(height: screenHeight*0.02),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  "Weather App",
                  textStyle: TextStyle(
                    fontSize: 28,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                  speed: Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 2,
            ),
            SizedBox(height: screenHeight *0.2),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            
          ],
        ),
      ),
      ),
    );
  }
}
