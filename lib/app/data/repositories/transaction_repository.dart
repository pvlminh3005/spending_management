part of repositories;

class TransactionRepository {
  Future<void> createTransaction(TransactionModel data) async {
    await TransactionProvider.createTransaction(data);
  }

  Future<bool> updateTransactionPayment() {
    throw UnimplementedError();
  }

  Future<bool> createTransactionCharge(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  Future<bool> updateTransactionCharge() {
    throw UnimplementedError();
  }

  Future<List<TransactionModel>> getTransactionPayment({
    required int page,
    int? month,
  }) {
    return TransactionProvider.getListTransactions(
      page: page,
      month: month,
      type: TransactionType.payment,
    );
  }
}
