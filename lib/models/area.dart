import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

import 'name.dart';
import 'parameter.dart';

class Area extends Equatable {
  final String id,
      latitude,
      longitude,
      coordinate,
      type,
      region,
      level,
      description,
      domain,
      tags;
  final List<Name> names;
  final List<Parameter> parameters;

  const Area({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.coordinate,
    required this.type,
    required this.region,
    required this.level,
    required this.description,
    required this.domain,
    required this.tags,
    required this.names,
    required this.parameters,
  });

  factory Area.fromXmlElement(XmlElement element) {
    String id = element.getAttribute('id') ?? '';
    String latitude = element.getAttribute('latitude') ?? '';
    String longitude = element.getAttribute('longitude') ?? '';
    String coordinate = element.getAttribute('coordinate') ?? '';
    String type = element.getAttribute('type') ?? '';
    String region = element.getAttribute('region') ?? '';
    String level = element.getAttribute('level') ?? '';
    String description = element.getAttribute('description') ?? '';
    String domain = element.getAttribute('domain') ?? '';
    String tags = element.getAttribute('tags') ?? '';

    List<Name> names = element
        .findAllElements('name')
        .map((nameElement) => Name.fromXmlElement(nameElement))
        .toList();

    List<Parameter> parameters = element
        .findAllElements('parameter')
        .map((parameterElement) => Parameter.fromXmlElement(parameterElement))
        .toList();

    return Area(
      id: id,
      latitude: latitude,
      longitude: longitude,
      coordinate: coordinate,
      type: type,
      region: region,
      level: level,
      description: description,
      domain: domain,
      tags: tags,
      names: names,
      parameters: parameters,
    );
  }

  @override
  List<Object?> get props => [
        id,
        latitude,
        longitude,
        coordinate,
        type,
        region,
        level,
        description,
        domain,
        tags,
        names,
        parameters,
      ];
}
