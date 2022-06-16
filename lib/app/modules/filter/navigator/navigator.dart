import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/enum.dart';
import '../../../core/utilities/utilities.dart';
import '../../../routes/app_pages.dart';

Map<String, dynamic> argumentFilter({
  int? month,
  required CategoryType type,
}) =>
    {
      StringUtils.monthVal: month,
      StringUtils.typeVal: type,
    };

class FilterNavigator {
  FilterNavigator._();

  static Future<T?>? toFilter<T>({
    int? month,
    required CategoryType type,
  }) {
    return Get.toNamed<T>(
      Routes.filter,
      arguments: argumentFilter(
        month: month,
        type: type,
      ),
    );
  }
}
