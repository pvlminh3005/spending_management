import '../styles/style.dart';

class DateTimePickerUtils {
  DateTimePickerUtils._();

  static Future<String> picker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    var data = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(DateTime.now().year - 1),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
    );
    return data?.displayDate ?? DateTime.now().displayDate;
  }
}
