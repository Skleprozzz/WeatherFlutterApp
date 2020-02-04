import 'dart:math';

import 'package:WeatherFlutterApp/data/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailedWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  double cachedTempCelsius;

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(
          cityName: cityName,
          tempCelsius: cachedTempCelsius,
          tempFahre: cachedTempCelsius * 1.8 + 32);
    });
  }

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();

      if (random.nextBool()) {
        throw NetworkError();
      }

      cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();
      return Weather(cityName: cityName, tempCelsius: cachedTempCelsius);
    });
  }
}

class NetworkError extends Error {}
