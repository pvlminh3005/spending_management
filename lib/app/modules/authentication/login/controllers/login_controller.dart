import 'package:get/get.dart';

import '../../../../core/styles/style.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  String get phoneStr => phoneController.text;

  final _disabled = true.obs;
  bool get disabled => _disabled.value;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(Routes.dashboard);
    }
  }

  void onChangedInput(String value) {
    if (value.replaceAll(' ', '').length < 10) {
      _disabled(true);
    } else {
      _disabled(false);
    }
  }

  void toRegister() {
    Get.offAndToNamed(Routes.register);
  }

  @override
  void onClose() {
    phoneController.dispose();
  }
}
