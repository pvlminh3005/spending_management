part of repositories;

abstract class TransactionRepositoryBase {
  Future<void> createTransaction(TransactionModel data);
  Future<void> deleteTransaction({
    required TransactionType type,
    required String uidTransaction,
  });
  Future<List<TransactionModel>> getTransactions({
    required TransactionType type,
    required int page,
    int? month,
  });
  Future<void> updateTransaction({required TransactionModel data});

  // Future<void> updateCategoryTransaction({
  //   required CategoryModel category,
  //   required TransactionType transactionType,
  // });
}

class TransactionRepository implements TransactionRepositoryBase {
  @override
  Future<void> createTransaction(TransactionModel data) async {
    await TransactionProvider.createTransaction(data);
  }

  @override
  Future<void> updateTransaction({
    required TransactionModel data,
  }) async {
    await TransactionProvider.updateTransaction(data);
  }

  @override
  Future<void> deleteTransaction({
    required TransactionType type,
    required String uidTransaction,
  }) {
    return TransactionProvider.deleteTransaction(
        type: type, uidTransaction: uidTransaction);
  }

  @override
  Future<List<TransactionModel>> getTransactions({
    required TransactionType type,
    required int page,
    int? month,
  }) {
    return TransactionProvider.getListTransactions(
      page: page,
      month: month,
      type: type,
    );
  }

  Future<List<TransactionModel>> getTransactionPayment({
    required int page,
    int? month,
  }) {
    return getTransactions(
      page: page,
      month: month,
      type: TransactionType.payment,
    );
  }

  Future<List<TransactionModel>> getTransactionCharge({
    required int page,
    int? month,
  }) {
    return getTransactions(
      page: page,
      month: month,
      type: TransactionType.charge,
    );
  }

  // @override
  // Future<void> updateCategoryTransaction({
  //   required CategoryModel category,
  //   required TransactionType transactionType,
  // }) {
  //   return TransactionProvider.updateCategoryTransaction(
  //     category: category,
  //     transactionType: transactionType,
  //   );
  // }
}
