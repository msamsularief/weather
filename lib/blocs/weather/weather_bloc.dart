import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/utils/extensions.dart';
import 'package:xml/xml.dart' show XmlDocument;
import '../../models/humidity.dart';
import '../../models/parameter.dart';
import '../../models/temperature.dart';
import '../../utils/app_getter_name.dart';
import '../../utils/blacklist_regions.dart';
import '../../models/data.dart';
import '../../api/api_client.dart';
import '../../blocs/weather/weather_event.dart';
import '../../blocs/weather/weather_state.dart';
import '../../models/regency.dart';
import '../../models/region.dart';
import '../../models/weather.dart';
import '../../utils/prefs_keys.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' show Response;

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialize()) {
    on<GetRegionInfo>((event, emit) async {
      try {
        emit(RegionInfoLoading());

        SharedPreferences prefs = await SharedPreferences.getInstance();

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

          // DATA REGIONS
          regions
              .map((region) => region.propinsi.replaceAllMapped(
                    RegExp(r'([a-z])([A-Z])'),
                    (match) => '${match.group(1)} ${match.group(2)}',
                  ))
              .toList();

          // REGIONS MAP
          Map<String, dynamic> regionsMap = {
            "entries": regions.map((e) => e.toJson()).toList()
          };

          String? lastRegionChoosedData =
              prefs.getString(PrefsKeys.lastChoosenRegionKey);

          Region region;

          if (lastRegionChoosedData != null) {
            dynamic regionData = jsonDecode(lastRegionChoosedData);
            region = Region.fromJson(regionData);
          } else {
            region = regions.first;
          }

          // SET REGIONS TO LOCAL
          prefs.setString(
            PrefsKeys.listRegionsKey,
            jsonEncode(regionsMap),
          );

          // SET LAST CHOOSEN REGIONS TO LOCAL
          prefs.setString(
            PrefsKeys.lastChoosenRegionKey,
            jsonEncode(region.toJson()),
          );

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

        SharedPreferences prefs = await SharedPreferences.getInstance();

        // SET LAST CHOOSEN REGIONS TO LOCAL
        prefs.setString(
          PrefsKeys.lastChoosenRegionKey,
          jsonEncode(event.region.toJson()),
        );

        final String path = '/cuaca/${event.region.id}.json';
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

          weathers.removeWhere(
              (weather) => BlacklistRegions.ids.contains(event.region.id));

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
        emit(BMKGRegionLoading());

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.getString(PrefsKeys.listRegionsKey);

        String apiPath =
            "https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-${AppGetterName.region}.xml";

        final Response? response = await ApiClient().public().getBMKG(apiPath);

        if (response != null && response.statusCode == 200) {
          XmlDocument xmlDocument = XmlDocument.parse(response.body);
          Data data = Data.fromXml(xmlDocument.rootElement);

          // DATA REGIONS
          List<RegionFromBMKG> regions = data.forecast.areas
              .map((area) => RegionFromBMKG(
                    id: area.id,
                    propinsi: area.domain,
                    code: area.domain.replaceAll(" ", ""),
                    lat: area.latitude,
                    lon: area.longitude,
                  ))
              .toList();

          Map<String, dynamic> regionsMap = {
            "entries": regions.map((e) => e.toJson()).toList()
          };

          // SET REGIONS TO LOCAL
          prefs.setString(
            PrefsKeys.listRegionsKey,
            jsonEncode(regionsMap),
          );

          // SET LAST CHOOSEN REGIONS TO LOCAL
          prefs.setString(PrefsKeys.lastChoosenRegionKey,
              jsonEncode(regions.first.toJson()));

          emit(BMKGRegionLoaded(data, regions));
        } else {
          if (response == null) {
            throw "Cannot get data from Server.";
          }

          throw "${response.statusCode} : ${response.reasonPhrase}";
        }
      } catch (e) {
        debugPrint("CATCH ERROR : ${e.toString()}");
        emit(BMKGRegionFailure("CATCH ERROR : ${e.toString()}"));
      }
    });

    on<GetRegencyFromBMKG>((event, emit) async {
      try {
        emit(BMKGRegencyLoading());

        SharedPreferences prefs = await SharedPreferences.getInstance();

        String apiPath =
            "https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-${event.appGetterName}.xml";

        final Response? response = await ApiClient().public().getBMKG(apiPath);

        if (response != null && response.statusCode == 200) {
          XmlDocument xmlDocument = XmlDocument.parse(response.body);

          Data data = Data.fromXml(xmlDocument.rootElement);

          data.forecast.areas.removeWhere(
            (area) =>
                !area.names.last.value.contains('Kab.') &&
                !area.names.last.value.contains('Kota'),
          );

          // DATA REGENCIES
          List<Regency> regencies = data.forecast.areas.map((area) {
            final Parameter paramT = area.parameters
                .where((param) => param.id == 't')
                .toList()
                .first;

            final Parameter paramH = area.parameters
                .where((param) => param.id == 'hu')
                .toList()
                .first;

            final Parameter paramW = area.parameters
                .where((param) => param.id == 'weather')
                .toList()
                .first;

            String description =
                area.description.replaceAll('Kab.', '').replaceAll('Kota', '');

            return Regency(
                id: area.id,
                name: area.names.last.value.replaceAll('Kab.', 'Kabupaten'),
                kecamatan: description,
                lat: area.latitude,
                lon: area.longitude,
                temperatures: paramT.timeRanges
                    .map(
                      (t) => Temperature(
                        id: (paramT.timeRanges.indexOf(t) + 1).toString(),
                        description: paramT.description,
                        type: paramT.type,
                        dateTime: DateTime.parse(t.datetime.toDefault()),
                        celcius: t.values.first.value,
                        fahrenheit: t.values.last.value,
                        code: paramW.timeRanges[paramT.timeRanges.indexOf(t)]
                            .values.first.value,
                      ),
                    )
                    .toList(),
                humidities: paramH.timeRanges
                    .map(
                      (hu) => Humidity(
                        id: (paramH.timeRanges.indexOf(hu) + 1).toString(),
                        description: paramH.description,
                        type: paramH.type,
                        datetime: hu.datetime,
                        value: hu.values.first.value,
                      ),
                    )
                    .toList(),
                weathers: paramW.timeRanges
                    .map(
                      (w) => WeatherFromBMKG(
                        id: (paramW.timeRanges.indexOf(w) + 1).toString(),
                        description: paramW.description,
                        type: paramW.type,
                        dateTime: DateTime.parse(w.datetime.toDefault()),
                        code: w.values.first.value,
                      ),
                    )
                    .toList());
          }).toList();

          regencies.sort((a, b) => a.name.compareTo(b.name));

          // REGENCIES MAP
          Map<String, dynamic> regenciesMap = {
            "entries": regencies.map((e) => e.toJson()).toList()
          };

          // SET REGENCIES TO LOCAL
          prefs.setString(
            PrefsKeys.listRegenciesKey,
            jsonEncode(regenciesMap),
          );

          emit(BMKGRegencyLoaded(regencies));
        } else {
          if (response == null) {
            throw "Cannot get data from Server.";
          }

          throw "${response.statusCode} : ${response.reasonPhrase}";
        }
      } catch (e) {
        debugPrint("CATCH ERROR : ${e.toString()}");
        emit(BMKGRegencyFailure("CATCH ERROR : ${e.toString()}"));
      }
    });

    on<GetTemperatureFromBMKG>((event, emit) async {
      try {
        emit(BMKGTemperatureLoading());

        await Future.delayed(
          const Duration(milliseconds: 600),
          () => emit(
            BMKGTemperatureLoaded(event.regency.temperatures),
          ),
        );
      } catch (e) {
        emit(BMKGTemperatureFailure(e.toString()));
      }
    });
  }
}
