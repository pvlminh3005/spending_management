import '../../core/styles/style.dart';

class ThemeModel {
  final String name;
  final Color primary;
  final Color secondary;
  final Color background;

  ThemeModel({
    this.name = '',
    required this.primary,
    required this.secondary,
    required this.background,
  });
}

final List<ThemeModel> themeSupport = [
  ThemeModel(
    name: 'theme_1',
    primary: const Color(0xFF00a8ff),
    secondary: const Color(0xFF27ae60),
    background: const Color(0xFFdfe6e9),
  ),
];
