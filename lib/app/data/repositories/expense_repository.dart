part of repositories;

abstract class TransactionRepositoryBase {
  Future<List<TransactionModel>> getList({TransactionType? transactionType});
}

class TransactionRepository extends TransactionRepositoryBase {
  @override
  Future<List<TransactionModel>> getList({TransactionType? transactionType}) {
    try {
      return TransactionProvider.getList(transactionType: transactionType)
          .then((value) => value.data);
    } catch (e) {
      rethrow;
    }
  }
}
