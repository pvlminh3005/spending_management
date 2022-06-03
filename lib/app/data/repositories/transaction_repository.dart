part of repositories;

abstract class TransactionRepositoryBase {
  Future getListPayment();
  Future<ListTransactionModel> getListCharge();
}

class TransactionRepository extends TransactionRepositoryBase {
  @override
  Future<ListTransactionModel> getListCharge() {
    return TransactionProvider.getListCharge();
  }

  @override
  Future getListPayment() {
    return TransactionProvider.getListPayment();
  }
}
