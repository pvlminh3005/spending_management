import 'package:get/get.dart';
import '../../../data/models/transaction_model.dart';
import '../../../routes/app_pages.dart';

class TransactionDetailNavigator {
  TransactionDetailNavigator._();

  static Future<T?>? toTransactionDetail<T>({
    TransactionModel? args,
  }) {
    return Get.toNamed<T>(
      Routes.transactionDetail,
      arguments: args,
    );
  }
}
