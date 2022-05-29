import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/app_utils.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';

class VerifyPhoneController extends GetxController {
  AuthService get auth => Get.find();

  final verifyController = TextEditingController();
  String get verifyStr => verifyController.text;

  String yourPhone = Get.arguments ?? '0916115535';

  final _disabled = true.obs;
  bool get disabled => _disabled.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    formatPhone();
    super.onInit();
  }

  void formatPhone() {
    yourPhone = MaskTextInputFormatter(
      initialText: yourPhone.substring(1),
      mask: '+84## ### ####',
    ).getMaskedText();
  }

  void onChange() {
    if (verifyStr.length < 6) {
      _disabled(true);
    } else {
      _disabled(false);
    }
  }

  void verifyOTP() {
    _isLoading(true);
    auth.verifyOTP(
      smsCode: verifyStr,
      onSuccess: (UserCredential user) {
        _isLoading(false);
        Get.offAndToNamed(Routes.dashboard);
      },
      onError: (e) {
        _isLoading(false);
      },
    );
  }

  @override
  void onClose() {
    verifyController.dispose();
  }
}
