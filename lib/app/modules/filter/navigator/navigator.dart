import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class FilterNavigator {
  FilterNavigator._();

  static Future<T?>? toTransactionDetail<T>({
    int? args,
  }) {
    return Get.toNamed<T>(
      Routes.filter,
      arguments: args,
    );
  }
}
