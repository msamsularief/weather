import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetWeatherInfo extends WeatherEvent {
  final String id;

  GetWeatherInfo(this.id);
  @override
  String toString() => "GET Weather Information ID: $id";
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
  final String appGetterName;

  GetRegionFromBMKG(this.appGetterName);
  @override
  String toString() => "GetRegionFromBMKG";
}
