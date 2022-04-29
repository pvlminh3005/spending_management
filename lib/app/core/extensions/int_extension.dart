import 'package:intl/intl.dart';

extension NumGenericExtensions<T extends num> on T? {
  String get format {
    if (this == null) {
      return '';
    } else {
      return NumberFormat().format(this);
    }
  }
}
