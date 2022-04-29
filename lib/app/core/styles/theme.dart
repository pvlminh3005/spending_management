part of style;

class AppTheme {
  AppTheme._();

  factory AppTheme() => _instance;

  static final AppTheme _instance = AppTheme._();

  // static const Color subtitleColor = Color(0xff727272);

  static LinearGradient linearGradient(BuildContext context) {
    return LinearGradient(
      colors: [
        context.primary,
        context.secondary,
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  static ThemeData getCollectionTheme({
    required ThemeModel theme,
    required Brightness brightness,
    required BuildContext context,
    String? font,
  }) {
    late ColorScheme colorScheme;
    switch (brightness) {
      case Brightness.light:
        colorScheme = ColorScheme.light(
          primary: theme.primary,
          secondary: theme.secondary,
          surface: Colors.white,
          background: theme.background,
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
    return ThemeData(
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
      fontFamily: font,
      textTheme: context.textTheme.copyWith(
        bodyText1: context.bodyText1.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        bodyText2: context.bodyText2.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        subtitle1: context.subtitle1.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        subtitle2: context.subtitle2.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        caption: context.caption.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        overline: context.overline.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
        ),
        headline6: context.headline6.copyWith(
          height: 1.2,
          fontFamily: font,
          letterSpacing: 0.02,
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
