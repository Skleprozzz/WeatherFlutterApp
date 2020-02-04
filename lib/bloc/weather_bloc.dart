import 'dart:async';

import 'package:WeatherFlutterApp/data/model/weather.dart';
import 'package:WeatherFlutterApp/data/warther_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    // Emitting a state from the asynchronous generator
    yield WeatherLoading();
    // Branching the executed logic by checking the event type
    if (event is GetWeather) {
      // Emit either Loaded or Error
      yield await _getWeather(event, repository.fetchWeather);
    } else if (event is GetDetailedWeather) {
      yield await _getWeather(event, repository.fetchDetailedWeather);
    }
  }

  Future<WeatherState> _getWeather(event, Function getWeather) async {
    try {
      final weather = await getWeather(event.cityName);
      return WeatherLoaded(weather);
    } on NetworkError {
      return WeatherError("Couldn`t fetch weather. Is the device online?");
    }
  }
}
