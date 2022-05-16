import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/setting_service.dart';

class ProfileController extends GetxController {
  AuthService get auth => Get.find();
  SettingService get setting => Get.find();

  final _isDarkMode = false.obs;
  bool get isDarkMode => _isDarkMode.value;

  void changeMode() {
    _isDarkMode(!isDarkMode);

    if (isDarkMode) {
      setting.changeTheme(mode: ThemeMode.dark);
    } else {
      setting.changeTheme(mode: ThemeMode.light);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
