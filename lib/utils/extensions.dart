import 'package:intl/intl.dart';

const String _locale = "id_ID";

extension ToDate on String {
  String toDDMMMyyyy() {
    DateFormat formater = DateFormat('EEEE, dd MMMM HH:mm', _locale);
    int parser = int.parse(this);
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(parser);
    String formatted = formater.format(toFormat);

    return formatted;
  }

  String toDefault() {
    int year = int.parse(substring(0, 4));
    int month = int.parse(substring(4, 6));
    int day = int.parse(substring(6, 8));
    int hour = int.parse(substring(8, 10));
    int minute = int.parse(substring(10, 12));

    DateTime dateTime = DateTime(year, month, day, hour, minute);
    return dateTime.toString();
  }

  /// Mengambil HH:MM pada DateTime (String)
  String toHM() {
    DateFormat formatter = DateFormat('HH:mm', _locale);

    int parser = int.parse(this);
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(parser);
    String formatted = formatter.format(toFormat);

    return formatted;
  }
}
