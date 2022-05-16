import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/data/services/setting_service.dart';
import 'app/routes/app_pages.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  SettingService get theme => Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(SettingService());
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return GestureDetector(
      child: GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        themeMode: theme.themeMode,
        initialRoute: AppPages.initialRoute,
        getPages: AppPages.routes,
        theme: theme.lightTheme.copyWith(
          textTheme: theme.lightTheme.textTheme,
        ),
        darkTheme: theme.darkTheme.copyWith(
          textTheme: theme.darkTheme.textTheme,
        ),
        routingCallback: (_) {
          WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
        },
      ),
      onTap: () {
        WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
      },
    );
  }
}
