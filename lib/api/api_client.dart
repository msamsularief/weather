import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Map<String, String> get _buildHeaders => {'Content-type': 'application/json'};

class ApiClient {
  static final ApiClient _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  ApiClient._internal();

  ApiResource public() => ApiResource(dotenv.env['BASE_URL']!);
}

class ApiResource {
  final String baseApi;

  ApiResource(this.baseApi);

  Future<http.Response?> get(String apiPath) async {
    try {
      Uri uri = Uri.parse("$baseApi$apiPath");

      final http.Response response =
          await http.get(uri, headers: _buildHeaders);

      return response;
    } on HttpException catch (e) {
      throw "on HTTP Exception ERROR : ${e.message}";
    }
  }

  Future<http.Response?> getBMKG(String apiPath) async {
    try {
      Uri uri = Uri.parse(apiPath);

      final http.Response response =
          await http.get(uri, headers: _buildHeaders);

      return response;
    } on HttpException catch (e) {
      throw "on HTTP Exception ERROR : ${e.message}";
    }
  }
}
