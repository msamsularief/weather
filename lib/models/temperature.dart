import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Temperature extends Equatable {
  final String id, description, type, celcius, fahrenheit, code;
  final DateTime dateTime;

  const Temperature({
    required this.id,
    required this.description,
    required this.type,
    required this.dateTime,
    required this.celcius,
    required this.fahrenheit,
    required this.code,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      dateTime: DateTime.parse(json['dateTime']),
      celcius: json['celcius'],
      fahrenheit: json['fahrenheit'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['type'] = type;
    data['dateTime'] = dateTime.toString();
    data['celcius'] = celcius;
    data['fahrenheit'] = fahrenheit;
    data['code'] = code;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        description,
        type,
        dateTime,
        celcius,
        fahrenheit,
        code,
      ];
}
