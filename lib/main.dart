import 'package:WeatherFlutterApp/bloc/weather_bloc.dart';
import 'package:WeatherFlutterApp/data/warther_repository.dart';
import 'package:WeatherFlutterApp/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        home: BlocProvider(
            create: (context) => WeatherBloc(FakeWeatherRepository()),
            child: WeatherSearchPage()));
  }
}
