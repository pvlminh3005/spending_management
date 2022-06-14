import 'package:tiengviet/tiengviet.dart';

extension StringCasingExt on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get deleteFirstStr => substring(1);

  String get phoneVerify => '+84${replaceAll(' ', '').deleteFirstStr}';
  String get tiengViet => TiengViet.parse(this);
}
