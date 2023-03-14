import 'package:equatable/equatable.dart';

import '../../models/data.dart';
import '../../models/region.dart';
import '../../models/weather.dart';

class WeatherState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WeatherInitialize extends WeatherState {
  @override
  String toString() => 'WeatherInitialize';
}

class WeatherInfoLoading extends WeatherState {
  @override
  String toString() => 'WeatherInfoLoading';
}

class WeatherInfoLoaded extends WeatherState {
  final List<Weather> items;

  WeatherInfoLoaded(this.items);
  @override
  String toString() => 'WeatherInfoLoaded';
}

class WeatherInfoFailure extends WeatherState {
  final String message;

  WeatherInfoFailure(this.message);
  @override
  String toString() => 'WeatherInfoFailure';
}

class RegionInfoLoading extends WeatherState {
  @override
  String toString() => 'RegionInfoLoading';
}

class RegionInfoLoaded extends WeatherState {
  final List<Region> items;

  RegionInfoLoaded(this.items);
  @override
  String toString() => 'RegionInfoLoaded';
}

class RegionInfoFailure extends WeatherState {
  final String message;

  RegionInfoFailure(this.message);
  @override
  String toString() => 'RegionInfoFailure';
}

class BMKGLoading extends WeatherState {
  @override
  String toString() => 'BMKGLoading';
}

class BMKGLoaded extends WeatherState {
  final Data item;

  BMKGLoaded(this.item);
  @override
  String toString() => 'BMKGLoaded';
}

class BMKGFailure extends WeatherState {
  final String message;

  BMKGFailure(this.message);
  @override
  String toString() => 'BMKGFailure';
}
