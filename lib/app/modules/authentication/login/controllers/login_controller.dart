import 'package:get/get.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/app_utils.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../data/services/notification_service.dart';
import '../../../../routes/app_pages.dart';

const maxLength = 13;

class LoginController extends GetxController {
  AuthService get auth => Get.find();

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final _disabled = true.obs;
  final _isLoading = false.obs;

  String get phoneStr => phoneController.text;
  bool get disabled => _disabled.value;
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
            parameters: {
              StringUtils.verificationId: verificationId,
              StringUtils.phoneNumber: phoneStr,
            },
          );
          _isLoading(false);
        },
        onFailed: (e) {
          _isLoading(false);
          AppUtils.toast(e.message!.toString());
        },
      );
    } else {
      _isLoading(false);
    }
  }

  void onChangedInput(String value) {
    if (value.replaceAll(' ', '').length < 10) {
      _disabled(true);
    } else {
      _disabled(false);
      WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
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
