import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Weather extends Equatable {
  final DateTime jamCuaca;
  final String kodeCuaca;
  final String cuaca;
  final String humidity;
  final String tempC;
  final String tempF;

  const Weather({
    required this.jamCuaca,
    required this.kodeCuaca,
    required this.cuaca,
    required this.humidity,
    required this.tempC,
    required this.tempF,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      jamCuaca: DateTime.parse(json['jamCuaca']),
      kodeCuaca: json['kodeCuaca'],
      cuaca: json['cuaca'],
      humidity: json['humidity'],
      tempC: json['tempC'],
      tempF: json['tempF'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jamCuaca'] = jamCuaca;
    data['kodeCuaca'] = kodeCuaca;
    data['cuaca'] = cuaca;
    data['humidity'] = humidity;
    data['tempC'] = tempC;
    data['tempF'] = tempF;
    return data;
  }

  Weather copyWith() => Weather(
        jamCuaca: jamCuaca,
        kodeCuaca: kodeCuaca,
        cuaca: cuaca,
        humidity: humidity,
        tempC: tempC,
        tempF: tempF,
      );

  @override
  List<Object?> get props => [
        jamCuaca,
        kodeCuaca,
        cuaca,
        humidity,
        tempC,
        tempF,
      ];
}

@immutable
class WeatherFromBMKG extends Equatable {
  final String id, description, type, code;
  final DateTime dateTime;

  const WeatherFromBMKG({
    required this.id,
    required this.description,
    required this.type,
    required this.dateTime,
    required this.code,
  });

  factory WeatherFromBMKG.fromJson(Map<String, dynamic> json) =>
      WeatherFromBMKG(
        id: json['id'],
        description: json['description'],
        type: json['type'],
        dateTime: DateTime.parse(json['dateTime']),
        code: json['code'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['type'] = type;
    data['dateTime'] = dateTime.toString();
    data['code'] = code;
    return data;
  }

  @override
  List<Object?> get props => [id, description, type, dateTime, code];
}
