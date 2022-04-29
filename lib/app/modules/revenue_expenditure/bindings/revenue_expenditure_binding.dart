import 'package:get/get.dart';

import '../controllers/revenue_expenditure_controller.dart';

class RevenueExpenditureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RevenueExpenditureController>(
      () => RevenueExpenditureController(),
    );
  }
}
