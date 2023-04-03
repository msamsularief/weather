import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/models/humidity.dart';
import 'package:weather/models/temperature.dart';
import 'package:weather/models/weather.dart';

@immutable
class Regency extends Equatable {
  final String id, name, kecamatan, lat, lon;
  final List<Temperature> temperatures;
  final List<Humidity> humidities;
  final List<WeatherFromBMKG> weathers;

  const Regency({
    required this.id,
    required this.name,
    required this.kecamatan,
    required this.lat,
    required this.lon,
    required this.temperatures,
    required this.humidities,
    required this.weathers,
  });

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['id'],
      name: json['name'],
      kecamatan: json['kecamatan'],
      lat: json['latitude'],
      lon: json['longitude'],
      temperatures: json['temperatures'],
      humidities: json['humidities'],
      weathers: json['weathers'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['propinsi'] = name;
    data['kecamatan'] = kecamatan;
    data['latitude'] = lat;
    data['longitude'] = lon;
    data['temperatures'] = temperatures;
    data['humidities'] = humidities;
    data['weathers'] = weathers;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        kecamatan,
        lat,
        lon,
        temperatures,
        humidities,
        weathers,
      ];
}
