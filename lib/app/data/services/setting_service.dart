import 'package:get/get.dart';

import '../../core/styles/style.dart';
import '../models/theme_model.dart';

List<String> fontSupport = <String>[
  'NotoSans',
  'OpenSans',
  'Roboto',
];

class SettingService extends GetxService {
  SettingService();

  ThemeModel currentTheme = themeSupport.first;

  String currentFont = 'NotoSans';

  late ThemeData lightTheme = AppTheme.getCollectionTheme(
    theme: currentTheme,
    brightness: Brightness.light,
    font: currentFont,
  );

  late ThemeData darkTheme = AppTheme.getCollectionTheme(
    theme: currentTheme,
    brightness: Brightness.dark,
    font: currentFont,
  );

  ThemeMode themeMode = ThemeMode.light;

  @override
  void onInit() {
    changeTheme(
      mode: ThemeMode.light,
      font: currentFont,
    );
    super.onInit();
  }

  void changeTheme({ThemeModel? theme, ThemeMode? mode, String? font}) {
    currentTheme = theme ?? currentTheme;
    themeMode = mode ?? themeMode;
    currentFont = font ?? currentFont;

    switch (mode) {
      case ThemeMode.dark:
        Get.changeTheme(AppTheme.getCollectionTheme(
          theme: currentTheme,
          brightness: Brightness.dark,
          font: currentFont,
        ));
        Get.changeThemeMode(themeMode);

        break;
      default:
        Get.changeTheme(AppTheme.getCollectionTheme(
          theme: currentTheme,
          brightness: Brightness.light,
          font: currentFont,
        ));
        Get.changeThemeMode(themeMode);

        break;
    }
  }
}
