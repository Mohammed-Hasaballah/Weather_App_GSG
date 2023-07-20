// ignore_for_file: avoid_print

import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

import '../utilities/constants.dart';

class WeatherModel {
  late double temp;
  late int weatherId;
  late String cityName;
  late String weatherDesc;

  Future<void> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, dynamic> weatherInfo = await NetworkHelper(
            url:
                'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$kGSGApiKey&units=metric')
        .getData();

    print(weatherInfo);
    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    cityName = weatherInfo['name'];
    weatherDesc = weatherInfo['weather'][0]['main'];
    print(weatherDesc);
  }

  Future<void> getWeatherByCity(String cityN) async {
    Map<String, dynamic> weatherInfo = await NetworkHelper(
            url:
                'https://api.openweathermap.org/data/2.5/weather?q=$cityN&appid=3f1c842dfa02d9953dec0a3ca7643ba5&units=metric')
        .getData();

    print(weatherInfo);
    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    cityName = weatherInfo['name'];
    weatherDesc = weatherInfo['weather'][0]['main'].tolowerCase();
  }

  String getWeatherIcon() {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
