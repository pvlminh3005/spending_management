import 'package:get/get.dart';

import '../controllers/paybook_controller.dart';

class PaybookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaybookController>(
      () => PaybookController(),
    );
  }
}
