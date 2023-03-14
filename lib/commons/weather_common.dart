import 'package:flutter/rendering.dart';

import '../models/weather.dart';

class WeatherCommon {
  /// Pilih item [selectedWeather] berdasarkan waktu saat ini.
  static void selectWeather(List<Weather> items, void Function(Weather) onComplete) {
    Weather? selectedWeather; // Item cuaca yang dipilih

    DateTime now = DateTime.now(); // Tanggal dan waktu saat ini

    int hour = now.hour; // Jam saat ini

    if (hour >= 18 && hour < 24) {
      // Pilih item dengan jamCuaca 18
      selectedWeather = items.firstWhere(
        (item) => now.day == item.jamCuaca.day && item.jamCuaca.hour == 18,
      );
    } else if (hour >= 12 && hour < 18) {
      // Pilih item dengan jamCuaca 12
      selectedWeather = items.firstWhere(
        (item) => now.day == item.jamCuaca.day && item.jamCuaca.hour == 12,
      );
    } else if (hour >= 6 && hour < 12) {
      // Pilih item dengan jamCuaca 6
      selectedWeather = items.firstWhere(
        (item) => now.day == item.jamCuaca.day && item.jamCuaca.hour == 6,
      );
    } else {
      // Pilih item dengan jamCuaca 0
      selectedWeather = items.firstWhere(
        (item) => now.day == item.jamCuaca.day && item.jamCuaca.hour == 0,
      );
    }

    debugPrint(
      'ITEM : ${selectedWeather.jamCuaca.hour} : ${selectedWeather.jamCuaca.hour}',
    );

    return onComplete(selectedWeather);
  }
}
