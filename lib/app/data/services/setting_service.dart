import 'package:get/get.dart';

import '../../core/styles/style.dart';
import '../models/theme_model.dart';

class SettingService extends GetxService {
  SettingService();

  ThemeModel currentTheme = themeSupport.first;

  late ThemeData lightTheme = AppTheme.getCollectionTheme(
    theme: currentTheme,
    brightness: Brightness.light,
  );

  late ThemeData darkTheme = AppTheme.getCollectionTheme(
    theme: currentTheme,
    brightness: Brightness.dark,
  );

  ThemeMode themeMode = ThemeMode.light;

  @override
  void onInit() {
    Get.changeTheme(lightTheme);
    super.onInit();
  }

  void changeTheme({ThemeModel? theme, ThemeMode? mode, String? font}) {
    currentTheme = theme ?? currentTheme;
    themeMode = mode ?? themeMode;
    switch (mode) {
      case ThemeMode.dark:
        Get.changeTheme(AppTheme.getCollectionTheme(
          theme: currentTheme,
          brightness: Brightness.dark,
        ));
        Get.changeThemeMode(themeMode);
        break;
      case ThemeMode.light:
        Get.changeTheme(AppTheme.getCollectionTheme(
          theme: currentTheme,
          brightness: Brightness.light,
        ));
        Get.changeThemeMode(themeMode);
        break;

      default:
        Get.changeTheme(AppTheme.getCollectionTheme(
          theme: currentTheme,
          brightness: Brightness.light,
        ));
        Get.changeThemeMode(themeMode);
    }
  }
}
