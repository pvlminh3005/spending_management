import 'package:get/get.dart';

import '../controllers/charge_manage_controller.dart';

class ChargeManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChargeManageController>(
      () => ChargeManageController(),
    );
  }
}
