import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get displayDate => DateFormat('dd/MM/yyyy').format(this);
  String get displayDateTime => DateFormat.yMMMMd().add_Hms().format(this);

  static DateTime parseDate(String date) =>
      DateFormat('dd/MM/yyyy').parse(date);
}
