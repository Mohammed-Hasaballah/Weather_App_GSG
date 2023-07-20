// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilities/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  void getWeatherData() async {
    WeatherModel weatherInfo = WeatherModel();
    await weatherInfo.getCurrentLocationWeather();
    if (mounted) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) =>
                  LocationScreen(weatherData: weatherInfo))));
    }
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Spartan MB'),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Your quick weather report',
              style: TextStyle(
                  color: Color.fromARGB(255, 202, 199, 199),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Spartan MB'),
            ),
            SizedBox(
              height: 40,
            ),
            SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
