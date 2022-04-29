import 'package:get/get.dart';

import '../../core/styles/style.dart';
import '../models/theme_model.dart';

class SettingService extends GetxService {
  SettingService(this.context);
  final BuildContext context;

  ThemeModel currentTheme = themeSupport.first;

  late ThemeData lightTheme = AppTheme.getCollectionTheme(
    theme: currentTheme,
    brightness: Brightness.light,
    context: context,
  );

  ThemeMode themeMode = ThemeMode.light;

  @override
  void onInit() {
    Get.changeTheme(lightTheme);
    super.onInit();
  }
}
