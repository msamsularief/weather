import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

class Value extends Equatable {
  final String unit;
  final String value;

  const Value({
    required this.unit,
    required this.value,
  });

  factory Value.fromXmlElement(XmlElement element) {
    String unit = element.getAttribute('unit') ?? '';
    String value = element.text;

    return Value(
      unit: unit,
      value: value,
    );
  }

  @override
  List<Object?> get props => [unit, value];
}
