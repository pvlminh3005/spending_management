import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../core/utilities/date_time_picker_utils.dart';

class TransactionDetailController extends GetxController {
  final dateController =
      TextEditingController(text: DateTime.now().displayDate);
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> chooseDate(BuildContext context) async {
    dateController.text = await DateTimePickerUtils.picker(context);
  }

  @override
  void onClose() {
    dateController.dispose();
    amountController.dispose();
    descriptionController.dispose();
  }
}
