import 'package:intl/intl.dart';

extension NumGenericExtensions<T extends num> on T? {
  String get format {
    if (this == null) {
      return '';
    } else {
      return NumberFormat().format(this);
    }
  }

  String get formatCard {
    final buffer = StringBuffer();
    final convertStr = toString();

    for (int i = 0; i < convertStr.length; i++) {
      buffer.write(convertStr[i]);
      int index = i + 1;
      if (index % 4 == 0 && index != convertStr.length) {
        buffer.write('  ');
      }
    }
    return buffer.toString();
  }
}

// extension DateExt on int {
//   DateTime get date => DateTime.fromMillisecondsSinceEpoch(this);
//   String get time => DateFormat.yMMMMd('ja').add_Hm().format(date);

//   String get timeAgo => timeago.format(
//         date,
//         locale: 'ja',
//         allowFromNow: true,
//       );
// }
