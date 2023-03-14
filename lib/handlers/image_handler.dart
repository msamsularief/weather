import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageHandler {
  String network(String? imagePath) {
    String pathUrl = "${dotenv.env['BASE_URL']}/icon/$imagePath.png";
    return pathUrl;
  }
}
