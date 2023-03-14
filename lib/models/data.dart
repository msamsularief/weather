import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

import 'forecast.dart';

class Data extends Equatable {
  final String source, productionCenter;
  final Forecast forecast;

  const Data({
    required this.source,
    required this.productionCenter,
    required this.forecast,
  });

  factory Data.fromXml(XmlElement xml) {
    return Data(
      source: xml.getAttribute('source') ?? '',
      productionCenter: xml.getAttribute('productioncenter') ?? '',
      forecast: Forecast.fromXml(
          xml.getElement('forecast') ?? XmlElement(XmlName('dummy'))),
    );
  }

  @override
  List<Object?> get props => [source, productionCenter, forecast];
}
