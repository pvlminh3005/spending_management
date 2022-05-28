part of providers;

class ExpenseProvider {
  static Future<ResponseData<List<ExpenseModel>>> getList(
      {ExpenseType? expenseType}) async {
    try {
      await 1.delay();
      if (expenseType == null) {
        return ResponseData(data: fakeData);
      } else {
        return ResponseData(
          data: fakeData
              .where((element) => element.expenseType == expenseType)
              .toList(),
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
