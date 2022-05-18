import 'package:get/get.dart';

import '../../../../core/styles/style.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  AuthService get auth => Get.find();
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  String get phoneStr => phoneController.text;

  final _disabled = true.obs;
  bool get disabled => _disabled.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<void> toVerify() async {
    _isLoading(true);
    if (formKey.currentState!.validate()) {
      await 2.delay(() {
        Get.toNamed(
          Routes.verifyPhone,
          arguments: phoneStr,
        );
      });
    }
    _isLoading(false);
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
