part of providers;

class ExpenseProvider {
  static Future<List<ExpenseModel>> getList({int? expenseType}) async {
    try {
      await 1.delay();
      if (expenseType == null) {
        return fakeData;
      } else {
        return fakeData
            .where((element) => element.expenseType == expenseType)
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }
}
