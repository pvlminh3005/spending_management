import '../constants/enum.dart';
import '../utilities/utilities.dart';

extension ExpenseExt on ExpenseType {
  String get name {
    switch (this) {
      case ExpenseType.payment:
        return StringUtils.paymentType;
      case ExpenseType.charge:
        return StringUtils.chargeType;
    }
  }

  static ExpenseType create(String type) {
    switch (type) {
      case StringUtils.chargeType:
        return ExpenseType.charge;
      default:
        return ExpenseType.payment;
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
