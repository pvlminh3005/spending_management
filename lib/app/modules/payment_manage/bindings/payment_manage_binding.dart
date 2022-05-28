import 'package:get/get.dart';

import '../controllers/payment_manage_controller.dart';

class PaymentManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentManageController>(
      () => PaymentManageController(),
    );
  }
}
