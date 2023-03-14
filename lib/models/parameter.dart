import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

import 'timerange.dart';

class Parameter extends Equatable {
  final String id;
  final String description;
  final String type;
  final List<TimeRange> timeRanges;

  const Parameter({
    required this.id,
    required this.description,
    required this.type,
    required this.timeRanges,
  });

  factory Parameter.fromXmlElement(XmlElement element) {
    String id = element.getAttribute('id') ?? '';
    String description = element.getAttribute('description') ?? '';
    String type = element.getAttribute('type') ?? '';

    List<TimeRange> timeRanges = element
        .findElements('timerange')
        .map((timeLayout) => TimeRange.fromXmlElement(timeLayout))
        .toList();

    return Parameter(
      id: id,
      description: description,
      type: type,
      timeRanges: timeRanges,
    );
  }

  @override
  List<Object?> get props => [id, description, type, timeRanges];
}
