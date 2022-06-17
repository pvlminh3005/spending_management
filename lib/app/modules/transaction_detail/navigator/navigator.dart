import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/transaction_model.dart';
import '../../../routes/app_pages.dart';

Map<String, dynamic> _convert({
  TransactionModel? model,
  required TransactionType transactionType,
}) =>
    {
      StringUtils.transactionModelVal: model,
      StringUtils.transactionTypeVal: transactionType,
    };

class TransactionDetailNavigator {
  TransactionDetailNavigator._();

  static Future<T?>? toTransactionDetail<T>({
    TransactionModel? transactionModel,
    required TransactionType transactionType,
  }) {
    return Get.toNamed<T>(
      Routes.transactionDetail,
      arguments: _convert(
        transactionType: transactionType,
        model: transactionModel,
      ),
    );
  }
}
