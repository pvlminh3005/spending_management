import 'package:get/get.dart';
import '../styles/style.dart';

class DateTimePickerUtils {
  Future<DateTime?> dateTimePicker({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();

    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1980),
      lastDate: lastDate ?? DateTime(now.year, 12),
    );

    if (selectedDate != null) {
      final _now = DateTime.now(); //fetch again current date
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        _now.hour,
        _now.minute,
        _now.second,
        _now.millisecond,
        _now.microsecond,
      );
    }
    return null;
  }
}
