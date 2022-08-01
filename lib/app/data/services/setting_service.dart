import 'package:get/get.dart';

import '../../core/styles/style.dart';
import '../../core/utilities/preferences.dart';
import '../models/theme_model.dart';

class SettingUtils {
  static const String language = 'language';
  static const String theme = 'theme';
  static const String themeMode = 'themeMode';
  static const String themeSystem = 'system';
  static const String themeLight = 'light';
  static const String themeDark = 'dark';
  static const String font = 'font';
}

List<String> fontSupport = <String>[
  'NotoSans',
  'OpenSans',
  'Roboto',
];

class SettingService extends GetxService {
  SettingService();

  ThemeModel currentTheme = themeSupport.first;

  String currentFont = fontSupport.last;

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
    final oldThemeMode = Preferences.getString(SettingUtils.themeMode);
    if (oldThemeMode != null) {
      switch (oldThemeMode) {
        case SettingUtils.themeLight:
          themeMode = ThemeMode.light;
          break;
        case SettingUtils.themeDark:
          themeMode = ThemeMode.dark;
          break;
        default:
          themeMode = ThemeMode.light;
      }
    }

    changeTheme(
      mode: Preferences.pref.getString(SettingUtils.theme) ==
              SettingUtils.themeDark
          ? ThemeMode.dark
          : ThemeMode.light,
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

    Preferences.setString(SettingUtils.theme, currentTheme.name);
    Preferences.setString(SettingUtils.font, currentFont);
    switch (themeMode) {
      case ThemeMode.system:
        Preferences.setString(SettingUtils.theme, SettingUtils.themeSystem);
        break;
      case ThemeMode.dark:
        Preferences.setString(SettingUtils.theme, SettingUtils.themeDark);
        break;
      case ThemeMode.light:
        Preferences.setString(SettingUtils.theme, SettingUtils.themeLight);
        break;
      default:
        break;
    }
  }
}
