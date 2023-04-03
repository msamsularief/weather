import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Humidity extends Equatable {
  final String id, description, type, datetime, value;

  const Humidity({
    required this.id,
    required this.description,
    required this.type,
    required this.datetime,
    required this.value,
  });

  factory Humidity.fromJson(Map<String, dynamic> json) {
    return Humidity(
      id: json['id'],
      description: json['description'],
      type: json['type'],
      datetime: json['datetime'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['type'] = type;
    data['datetime'] = datetime;
    data['value'] = value;
    return data;
  }

  @override
  List<Object?> get props => [id, description, type, datetime, value];
}
