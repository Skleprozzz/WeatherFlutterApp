import 'package:WeatherFlutterApp/bloc/weather_bloc.dart';
import 'package:WeatherFlutterApp/data/model/weather.dart';
import 'package:WeatherFlutterApp/pages/weather_search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather weather;

  WeatherDetailPage({Key key, @required this.weather}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailedWeather(widget.weather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Detail"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(context, widget.weather);
              }
            },
          ),
        ));
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(weather.cityName,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700)),
        Text(
          "${weather.tempCelsius.toStringAsFixed(1)} *C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          "${weather.tempFahre.toStringAsFixed(1)} *F",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
