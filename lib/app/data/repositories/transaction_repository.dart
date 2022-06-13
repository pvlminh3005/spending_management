part of repositories;

class TransactionRepository {
  Future<void> createTransaction(TransactionModel data) async {
    await TransactionProvider.createTransaction(data);
  }

  Future<void> updateTransaction({
    required TransactionModel data,
  }) async {
    await TransactionProvider.updateTransaction(data);
  }

  Future<void> updateTransactionCharge() {
    throw UnimplementedError();
  }

  Future<void> deleteTransaction({
    required TransactionType type,
    required String uidTransaction,
  }) {
    return TransactionProvider.deleteTransaction(
        type: type, uidTransaction: uidTransaction);
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
