import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

class Issue extends Equatable {
  final String timestamp, year, month, day, hour, minute, second;

  const Issue({
    required this.timestamp,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  factory Issue.fromXml(XmlElement xml) {
    return Issue(
      timestamp: xml.getElement('timestamp')?.text ?? '',
      year: xml.getElement('year')?.text ?? '',
      month: xml.getElement('month')?.text ?? '',
      day: xml.getElement('day')?.text ?? '',
      hour: xml.getElement('hour')?.text ?? '',
      minute: xml.getElement('minute')?.text ?? '',
      second: xml.getElement('second')?.text ?? '',
    );
  }

  @override
  List<Object?> get props => [
        timestamp,
        year,
        month,
        day,
        hour,
        minute,
        second,
      ];
}
