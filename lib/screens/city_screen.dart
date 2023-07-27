import 'dart:ui';

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
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 213, 210, 210),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
            image: const AssetImage('images/city.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          )),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 40.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.2,
                  // ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 60, 59, 58)
                                  .withOpacity(0.4)),
                          child: const Text(
                            'Get Weather\nBy City Name: ',
                            style: kButtonTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          controller: _cityNameController,
                          style: const TextStyle(color: Colors.white),
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
                              borderSide:
                                  const BorderSide(color: kSecondaryColor),
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
                                      builder: ((context) => LocationScreen(
                                          weatherData: weatherInfo))));
                            }
                          }
                        },
                        child: const Text(
                          'Get Weather',
                          style: TextStyle(
                              color: Color.fromARGB(255, 213, 210, 210)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
