import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart' as prefs;
import '../../models/data.dart';
import 'package:xml/xml.dart' show XmlDocument;

import '../../api/api_client.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/weather/weather_state.dart';
import '../../models/region.dart';
import '../../models/weather.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show Response;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialize()) {
    on<GetRegionInfo>((event, emit) async {
      try {
        emit(RegionInfoLoading());

        const apiPath = "/cuaca/wilayah.json";
        final Response? response = await ApiClient().public().get(apiPath);

        if (response != null && response.statusCode == 200) {
          debugPrint("BODY : ${response.body}");
          var body = jsonDecode(response.body);
          final List<Region> regions = (body as List<dynamic>).map((region) {
            if (region != null) {
              return Region.fromJson(region);
            } else {
              throw "Region gagal dikonversi, mohon segera hubungi developer!";
            }
          }).toList();

          emit(RegionInfoLoaded(regions));
        } else {
          debugPrint('REGION ERROR : ${response?.reasonPhrase}');
          emit(RegionInfoFailure("Failure : ${response?.reasonPhrase}"));
        }
      } catch (e) {
        debugPrint('REGION ERROR CATCH : ${e.toString()}');
        emit(RegionInfoFailure(e.toString()));
      }
    });

    on<GetWeatherInfo>((event, emit) async {
      try {
        emit(WeatherInfoLoading());

        final String path = '/cuaca/${event.id}.json';
        final Response? response = await ApiClient().public().get(path);

        if (response != null && response.statusCode == 200) {
          var body = jsonDecode(response.body);

          final List<Weather> weathers = (body as List<dynamic>).map((weather) {
            if (weather != null) {
              return Weather.fromJson(weather);
            } else {
              throw "Weather gagal dikorversi, mohon segera hubungi developer!";
            }
          }).toList();

          debugPrint('WEATHERS : ${DateTime.now().hour}');
          debugPrint('WEATHERS : ${weathers.map((e) => e.jamCuaca).toList()}');
          debugPrint('WEATHERS : ${weathers.map((e) => e.tempC).toList()}');

          emit(WeatherInfoLoaded(weathers));
        } else {
          debugPrint('WEATHER ERROR : ${response?.reasonPhrase}');
          emit(WeatherInfoFailure("Failure : ${response?.reasonPhrase}"));
        }
      } catch (e) {
        debugPrint('WEATHER ERROR CATCH : ${e.toString()}');
        emit(WeatherInfoFailure(e.toString()));
      }
    });

    on<GetRegionFromBMKG>((event, emit) async {
      try {
        emit(BMKGLoading());

        String apiPath =
            "https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-${event.appGetterName}.xml";

        final Response? response = await ApiClient().public().getBMKG(apiPath);

        if (response != null && response.statusCode == 200) {
          // String parsed = XmlParser.handler(response);
          // String replaced = parsed.replaceAll(
          //   'xml:lang',
          //   'lang',
          // );
          // final data = response.body;

          // List<dynamic> areas =
          //     (data['data']['forecast']['area'] as List<dynamic>).map((area) {
          //   return area;
          // }).toList();

          XmlDocument xmlDocument = XmlDocument.parse(response.body);
          Data data = Data.fromXml(xmlDocument.rootElement);

          debugPrint("DATA : $data");

          emit(BMKGLoaded(data));
        } else {
          emit(BMKGFailure("FAILURE TO GET DATA"));
        }
      } catch (e) {
        debugPrint("CATCH ERROR : ${e.toString()}");
        emit(BMKGFailure("CATCH ERROR : ${e.toString()}"));
      }
    });
  }
}
