import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/utilities/preferences.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/notification_service.dart';
import 'root.dart';

Future<void> main() async {
  await initialApp();
  runApp(const RootApp());
}

Future<void> initialApp() async {
  Get.log('Starting services ...');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.setPreferences();
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => NotificationService().init());
  Get.log('All services started...');
}
