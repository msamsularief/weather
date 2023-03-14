import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

class Name extends Equatable {
  final String language, value;

  const Name({
    required this.language,
    required this.value,
  });

  factory Name.fromXmlElement(XmlElement element) {
    String language = element.getAttribute('xml:lang') ?? '';
    String value = element.text;

    return Name(
      language: language,
      value: value,
    );
  }

  @override
  List<Object?> get props => [language, value];
}
