part of providers;

class TransactionProvider {
  static Future<ListTransactionModel> getListPayment() async {
    try {
      await 2.delay();
      return paymentTransaction;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ListTransactionModel> getListCharge() async {
    try {
      await 1.delay();
      return chargeTransactions;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> createTransaction(Map<String, dynamic> data) async {
    try {} catch (e) {
      rethrow;
    }
  }
}
