import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../core/utilities/date_time_picker_utils.dart';

final _currentDate = DateTime.now().displayDate;

class TransactionDetailController extends GetxController {
  final dateController = TextEditingController(text: _currentDate);
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  void chooseDate(BuildContext context) {
    DateTimePickerUtils.dateTimePicker().then((date) {
      dateController.text = date.displayDate;
    });
  }

  @override
  void onClose() {
    dateController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }
}
