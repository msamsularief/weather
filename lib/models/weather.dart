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
