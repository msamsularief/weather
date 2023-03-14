import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

import 'area.dart';
import 'issue.dart';

class Forecast extends Equatable {
  final String domain;
  final Issue issue;
  final List<Area> areas;

  const Forecast({
    required this.domain,
    required this.issue,
    required this.areas,
  });

  factory Forecast.fromXml(XmlElement xml) {
    return Forecast(
      domain: xml.getAttribute('domain') ?? '',
      issue: Issue.fromXml(
          xml.getElement('issue') ?? XmlElement(XmlName('dummy'))),
      areas: xml
          .findElements('area')
          .map((areaXml) => Area.fromXmlElement(areaXml))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [domain, issue, areas];
}
