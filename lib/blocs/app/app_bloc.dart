import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/app/app_event.dart';
import '../../blocs/app/app_state.dart';
import '../../models/region.dart';
import '../../utils/prefs_keys.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(InitApp()) {
    on<StartUpEvent>((event, emit) async {
      emit(StartUpLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? lastRegionChoosedData =
            prefs.getString(PrefsKeys.lastChoosenRegionKey);
        String? listDataRegion = prefs.getString(PrefsKeys.listRegionsKey);

        RegionFromBMKG region;
        List<RegionFromBMKG> regions;

        debugPrint("${lastRegionChoosedData} \n\n $listDataRegion");

        if (lastRegionChoosedData != null) {
          dynamic regionData = jsonDecode(lastRegionChoosedData);
          region = RegionFromBMKG.fromJson(regionData);
        } else {
          throw "Cannot GET data Last Choosen RegionFromBMKG";
        }

        if (listDataRegion != null) {
          dynamic regionsData = jsonDecode(listDataRegion);

          regions = (regionsData['entries'] as List<dynamic>)
              .map((data) => RegionFromBMKG.fromJson(data))
              .toList();
        } else {
          throw "Cannot GET data Regions";
        }

        emit(StartUpSuccess(
          choosenRegion: region,
          regions: regions,
        ));
      } catch (e) {
        emit(StartUpFailure("CATCH ERROR : $e"));
      }
    });
  }
}
