part of repositories;

abstract class TransactionRepositoryBase {
  Future<ListTransactionModel> getListPayment();
  Future<ListTransactionModel> getListCharge();
}

class TransactionRepository extends TransactionRepositoryBase {
  @override
  Future<ListTransactionModel> getListCharge() {
    return TransactionProvider.getListCharge();
  }

  @override
  Future<ListTransactionModel> getListPayment() {
    return TransactionProvider.getListPayment();
  }
}
