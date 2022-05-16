import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/utilities/preferences.dart';
import 'app/data/services/auth_service.dart';
import 'root.dart';

Future<void> main() async {
  await initialApp();
  runApp(const RootApp());
}

Future<void> initialApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.setPreferences();
  await Get.putAsync(() => AuthService().init());
}
