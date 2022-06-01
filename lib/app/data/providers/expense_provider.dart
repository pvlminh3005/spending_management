part of providers;

class TransactionProvider {
  static Future<ResponseData<List<TransactionModel>>> getList(
      {TransactionType? transactionType}) async {
    try {
      await 1.delay();
      if (transactionType == null) {
        return ResponseData(data: fakeData);
      } else {
        return ResponseData(
          data: fakeData
              .where((element) => element.transactionType == transactionType)
              .toList(),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
