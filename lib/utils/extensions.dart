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

  /// Mengambil HH:MM pada DateTime (String)
  String toHM() {
    DateFormat formatter = DateFormat('HH:mm', _locale);

    int parser = int.parse(this);
    DateTime toFormat = DateTime.fromMillisecondsSinceEpoch(parser);
    String formatted = formatter.format(toFormat);

    return formatted;
  }
}
