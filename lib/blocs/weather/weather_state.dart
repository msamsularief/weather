import 'package:equatable/equatable.dart';

import '../../models/data.dart';
import '../../models/regency.dart';
import '../../models/region.dart';
import '../../models/temperature.dart';
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

class BMKGRegionLoading extends WeatherState {
  @override
  String toString() => 'BMKGRegionLoading';
}

class BMKGRegionLoaded extends WeatherState {
  final Data item;
  final List<RegionFromBMKG> regions;

  BMKGRegionLoaded(this.item, this.regions);
  @override
  String toString() => 'BMKGRegionLoaded';
}

class BMKGRegionFailure extends WeatherState {
  final String message;

  BMKGRegionFailure(this.message);
  @override
  String toString() => 'BMKGRegionFailure';
}

class BMKGRegencyLoading extends WeatherState {
  @override
  String toString() => 'BMKGRegencyLoading';
}

class BMKGRegencyLoaded extends WeatherState {
  final List<Regency> regencies;

  BMKGRegencyLoaded(this.regencies);
  @override
  String toString() => 'BMKGRegencyLoaded';
}

class BMKGRegencyFailure extends WeatherState {
  final String message;

  BMKGRegencyFailure(this.message);
  @override
  String toString() => 'BMKGRegencyFailure';
}

class BMKGTemperatureLoading extends WeatherState {
  @override
  String toString() => 'BMKGTemperatureLoading';
}

class BMKGTemperatureLoaded extends WeatherState {
  final List<Temperature> temperatures;

  BMKGTemperatureLoaded(this.temperatures);
  @override
  String toString() => 'BMKGTemperatureLoaded';
}

class BMKGTemperatureFailure extends WeatherState {
  final String message;

  BMKGTemperatureFailure(this.message);
  @override
  String toString() => 'BMKGTemperatureFailure';
}
