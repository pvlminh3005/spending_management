import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/styles/style.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';

const _minute = 1;

class VerifyPhoneController extends GetxController {
  AuthService get auth => Get.find();

  final verifyController = TextEditingController();
  final _disabled = true.obs;
  final _isLoading = false.obs;
  final _isResend = false.obs;

  String get verifyStr => verifyController.text;
  bool get disabled => _disabled.value;
  bool get isLoading => _isLoading.value;
  bool get isResend => _isResend.value;
  String yourPhone = Get.parameters[StringUtils.phoneNumber]!;

  @override
  void onReady() {
    formatPhone();
    super.onReady();
  }

  void formatPhone() {
    yourPhone = MaskTextInputFormatter(
      initialText: yourPhone,
      mask: '### ### ####',
    ).getMaskedText();
    _isResend(true);
  }

  void onChange() => _disabled(verifyStr.length < 6);

  void verifyOTP() {
    _isLoading(true);
    auth.verifyOTP(
      smsCode: verifyStr,
      onSuccess: (UserCredential user) {
        _isLoading(false);
        Get.offAllNamed(Routes.dashboard);
      },
      onError: (e) {
        _isLoading(false);
      },
    );
  }

  Future<void> resendOTP() async {
    _isResend(true);
    await (_minute * 60).delay(timeEnd);
  }

  void timeEnd() {
    _isResend(false);
  }

  @override
  void onClose() {
    verifyController.dispose();
    super.onClose();
  }
}
