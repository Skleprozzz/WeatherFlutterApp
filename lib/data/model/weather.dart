import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double tempCelsius;
  final double tempFahre;

  Weather(
      {@required this.cityName, @required this.tempCelsius, this.tempFahre});

  @override
  List<Object> get props => [cityName, tempCelsius, tempFahre];
}
