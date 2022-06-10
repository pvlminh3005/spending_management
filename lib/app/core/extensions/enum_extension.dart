import '../constants/constants.dart';
import '../utilities/utilities.dart';

extension TransactionExt on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.payment:
        return DbKeys.payment;
      default:
        return DbKeys.charge;
    }
  }

  static TransactionType create(String type) {
    switch (type) {
      case DbKeys.charge:
        return TransactionType.charge;
      default:
        return TransactionType.payment;
    }
  }

  static String convert(String type) {
    switch (type) {
      case DbKeys.charge:
        return StringUtils.chargeText;
      default:
        return StringUtils.paymentText;
    }
  }
}

extension CategoryExt on CategoryType {
  String get name {
    switch (this) {
      case CategoryType.payment:
        return DbKeys.payment;
      default:
        return DbKeys.charge;
    }
  }

  static CategoryType create(String type) {
    switch (type) {
      case DbKeys.charge:
        return CategoryType.charge;
      default:
        return CategoryType.payment;
    }
  }
}
