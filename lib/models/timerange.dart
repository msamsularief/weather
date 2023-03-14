import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

import 'value.dart';

class TimeRange extends Equatable {
  final String type;
  final String h;
  final String datetime;
  final List<Value> values;

  const TimeRange({
    required this.type,
    required this.h,
    required this.datetime,
    required this.values,
  });

  factory TimeRange.fromXmlElement(XmlElement element) {
    String type = element.getAttribute('type') ?? '';
    String h = (element.getAttribute('h') ?? '');
    String datetime = element.getAttribute('datetime') ?? '';

    List<Value> values = element
        .findAllElements('value')
        .map((value) => Value.fromXmlElement(value))
        .toList();

    return TimeRange(
      type: type,
      h: h,
      datetime: datetime,
      values: [...values],
    );
  }

  @override
  List<Object?> get props => [type, h, datetime, values];
}
