import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/styles/style.dart';
import '../../../core/utilities/date_time_picker_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/transaction/transaction.dart';

final _currentDate = DateTime.now().displayDate;

class TransactionDetailController extends GetxController {
  final dateController = TextEditingController(text: _currentDate);
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  String get dateStr => dateController.text;
  String get amountStr => amountController.text;
  String get descriptionStr => descriptionController.text;
  String titleButton = StringUtils.createTransaction;

  @override
  void onInit() {
    initialData();
    super.onInit();
  }

  void initialData() {
    TransactionModel? arguments = Get.arguments;

    if (arguments != null) {
      titleButton = StringUtils.updateTransaction;
      dateController.text = arguments.formatDate;
      amountController.text = arguments.displayBalance;
      descriptionController.text = arguments.description ?? '';
    }
  }

  void chooseDate(BuildContext context) {
    DateTimePickerUtils.dateTimePicker(
      initialDate: DateTimeExt.parseDate(dateStr),
    ).then((date) {
      if (date != null) {
        dateController.text = date.displayDate;
      }
    });
  }

  @override
  void onClose() {
    dateController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
