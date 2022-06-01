import '../constants/enum.dart';
import '../utilities/utilities.dart';

extension ExpenseExt on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.payment:
        return StringUtils.paymentType;
      case TransactionType.charge:
        return StringUtils.chargeType;
    }
  }

  static TransactionType create(String type) {
    switch (type) {
      case StringUtils.chargeType:
        return TransactionType.charge;
      default:
        return TransactionType.payment;
    }
  }

  static String convert(String type) {
    switch (type) {
      case StringUtils.chargeType:
        return StringUtils.chargeText;
      default:
        return StringUtils.paymentText;
    }
  }
}
