import 'package:get/get.dart';
import '../styles/style.dart';

class DateTimePickerUtils {
  DateTimePickerUtils._();

  static Future<DateTime?> dateTimePicker({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    return await showDatePicker(
      context: Get.context!,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(1980),
      lastDate: lastDate ?? DateTime(now.year, 12),
    );
  }
}
