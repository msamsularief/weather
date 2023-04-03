import 'package:equatable/equatable.dart';
import 'package:weather/models/regency.dart';
import 'package:weather/models/region.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherInfo extends WeatherEvent {
  final Region region;

  GetWeatherInfo(this.region);
  @override
  String toString() => "GET Weather Information ID: $region";
}

class GetRegionInfo extends WeatherEvent {
  @override
  String toString() => "GET Region Information";
}

class GetFromBMKG extends WeatherEvent {
  @override
  String toString() => "GET data from BMKG";
}

class GetRegionFromBMKG extends WeatherEvent {
  GetRegionFromBMKG();
  @override
  String toString() => "GetRegionFromBMKG";
}

class GetRegencyFromBMKG extends WeatherEvent {
  final String appGetterName;
  GetRegencyFromBMKG(this.appGetterName);
  @override
  String toString() => "GetRegencyFromBMKG";
}

class GetTemperatureFromBMKG extends WeatherEvent {
  final Regency regency;
  final String idArea;
  GetTemperatureFromBMKG(this.regency, this.idArea);
  @override
  String toString() => "GetTemperatureFromBMKG";
}
