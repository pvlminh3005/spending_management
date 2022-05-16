import 'package:get/get.dart';

import '../../core/utilities/preferences.dart';
import '../../core/utilities/string_utils.dart';
import '../../routes/app_pages.dart';
import '../providers/auth_provider.dart';

class AuthService extends GetxService {
  final _isAuth = false.obs;
  bool get isAuth => _isAuth.value;

  Future<AuthService> init() async {
    _isAuth(Preferences.pref.containsKey(StringUtils.token));
    return this;
  }

  Future<void> signIn(String phoneNumber) async {
    try {
      final response = await AuthProvider.signIn(phoneNumber);
      if (response) {
        Get.offAllNamed(Routes.dashboard);
      } else {
        //? something
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      final response = await AuthProvider.signOut();
      if (response) {
        Get.offAllNamed(Routes.login);
      }
    } catch (e) {
      rethrow;
    }
  }
}
