import 'package:get/get.dart';

import '../controllers/filter_controller.dart';

class FilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FilterController());
  }
}
