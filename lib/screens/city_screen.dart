import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather_app/services/weather.dart';

import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  final TextEditingController _cityNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    late String cityName;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 210, 210),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 210, 210),
        elevation: 0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 40.0,
            color: kSecondaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: null,
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Get Weather\nBy City Name: ',
                style: kButtonTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _cityNameController,
                style: const TextStyle(color: kSecondaryColor),
                decoration: InputDecoration(
                  labelText: 'Enter City:',
                  labelStyle: const TextStyle(color: kSecondaryColor),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kSecondaryColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: kSecondaryColor,
                  )),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: kSecondaryColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor),
              ),
              onPressed: () async {
                cityName = _cityNameController.text;
                if (cityName.isNotEmpty) {
                  WeatherModel weatherInfo = WeatherModel();
                  await weatherInfo.getWeatherByCity(cityName);
                  if (mounted) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                LocationScreen(weatherData: weatherInfo))));
                  }
                }
              },
              child: const Text(
                'Get Weather',
                style: TextStyle(color: Color.fromARGB(255, 213, 210, 210)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
