import 'package:get/get.dart';

import '../../core/utilities/preferences.dart';
import '../../core/utilities/string_utils.dart';

class AuthProvider {
  AuthProvider._();

  static Future<bool> signIn(String phoneNumber) async {
    try {
      await 2.delay(() {
        Preferences.setString(StringUtils.token, phoneNumber);
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> signOut() async {
    try {
      await Preferences.clear();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
