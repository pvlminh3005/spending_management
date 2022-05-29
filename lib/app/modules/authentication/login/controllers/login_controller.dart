import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../data/services/notification_service.dart';
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

  void signIn() {
    _isLoading(true);

    if (formKey.currentState!.validate()) {
      auth.signInWithPhoneNumber(
        phoneStr.phoneVerify,
        onCompleted: (phoneAuth) {},
        onSuccess: (verificationId, resendToken) {
          Get.toNamed(
            Routes.verifyPhone,
            arguments: verificationId,
          );
          _isLoading(false);
        },
        onFailed: (e) {},
      );
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
    // Get.offAndToNamed(Routes.register);
    Get.find<NotificationService>().sentMessage(
      MessagingModel(
        title: 'Chào bae',
        body: 'Yêu bae',
        data: {},
      ),
      StringUtils.messagingKey,
    );
  }

  @override
  void onClose() {
    phoneController.dispose();
  }
}
