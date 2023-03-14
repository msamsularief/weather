import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' show Response;

class XmlParser {
  static String handler(Response response) {
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(response.body);
    String json = xml2json.toGData();

    return json;
  }
}
