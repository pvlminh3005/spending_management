part of style;

class AppTheme {
  AppTheme._();

  factory AppTheme() => _instance;

  static final AppTheme _instance = AppTheme._();

  static LinearGradient linearGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        context.primary,
        context.secondary,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static ThemeData getCollectionTheme({
    required ThemeModel theme,
    required Brightness brightness,
    String? font,
  }) {
    late ColorScheme colorScheme;
    switch (brightness) {
      case Brightness.light:
        colorScheme = ColorScheme.light(
          primary: theme.primary,
          secondary: theme.secondary,
          surface: Colors.white,
          background: const Color(0xfffcfcfc),
          error: const Color(0xffD90615),
        );
        break;
      case Brightness.dark:
        colorScheme = ColorScheme.dark(
          primary: theme.primary,
          secondary: theme.secondary,
          surface: const Color(0xff121212),
          background: const Color(0xff010101),
          error: const Color(0xffD90615),
        );
        break;
      default:
    }

    final dark = colorScheme.brightness == Brightness.dark;
    final indicatorColor = dark ? colorScheme.onSurface : colorScheme.primary;
    final themeData = ThemeData(
      brightness: colorScheme.brightness,
      primaryColor: colorScheme.primary,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      bottomAppBarColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.onSurface.withOpacity(0.12),
      backgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.surface,
      errorColor: colorScheme.error,
      indicatorColor: indicatorColor,
      applyElevationOverlayColor: dark,
      colorScheme: colorScheme,
      fontFamily: 'NotoSans',
    );
    final textTheme = themeData.textTheme;
    return themeData.copyWith(
      textTheme: themeData.textTheme.copyWith(
        button: textTheme.button!.copyWith(
          fontSize: 14,
          height: 1.2,
          fontFamily: font,
        ),
        bodyText1: textTheme.bodyText1!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 14,
        ),
        bodyText2: textTheme.bodyText2!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 14,
        ),
        subtitle1: textTheme.subtitle1!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 16,
        ),
        subtitle2: textTheme.subtitle2!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 16,
        ),
        caption: textTheme.caption!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 12,
        ),
        overline: textTheme.overline!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 10,
        ),
        headline6: textTheme.headline6!.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
          fontSize: 20,
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor) {
    hexColor = hexColor ?? 'ffffff';
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(_getColorFromHex(hexColor));
}
