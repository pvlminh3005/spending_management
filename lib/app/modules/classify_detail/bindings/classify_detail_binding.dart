import 'package:get/get.dart';

import '../controllers/classify_detail_controller.dart';

class ClassifyDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassifyDetailController>(
      () => ClassifyDetailController(),
    );
  }
}
