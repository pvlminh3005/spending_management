import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../core/styles/style.dart';

class VerifyPhoneController extends GetxController {
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

  Future<void> verifyOTP() async {
    try {} catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    verifyController.dispose();
  }
}
