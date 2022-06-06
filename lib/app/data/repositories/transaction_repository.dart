part of repositories;

abstract class TransactionRepositoryBase {
  //* PAYMENT METHOD
  Future<List<TransactionModel>> getTransactionPayment();
  Future<bool> createTransactionPayment(Map<String, dynamic> data);
  Future<bool> updateTransactionPayment();

  //* CHARGE METHOD
  Future<List<TransactionModel>> getTransactionCharge();
  Future<bool> createTransactionCharge(Map<String, dynamic> data);
  Future<bool> updateTransactionCharge();
}

class TransactionRepository extends TransactionRepositoryBase {
  @override
  Future<bool> createTransactionPayment(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getTransactionPayment() {
    return TransactionProvider.getListTransactions(TransactionType.payment);
  }

  @override
  Future<bool> updateTransactionPayment() {
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionModel>> getTransactionCharge() {
    return TransactionProvider.getListTransactions(TransactionType.charge);
  }

  @override
  Future<bool> createTransactionCharge(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateTransactionCharge() {
    throw UnimplementedError();
  }
}
