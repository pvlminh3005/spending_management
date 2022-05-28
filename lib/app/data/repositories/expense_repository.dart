part of repositories;

abstract class ExpenseRepositoryBase {
  Future<List<ExpenseModel>> getList({ExpenseType? expenseType});
}

class ExpenseRepository extends ExpenseRepositoryBase {
  @override
  Future<List<ExpenseModel>> getList({ExpenseType? expenseType}) {
    try {
      return ExpenseProvider.getList(expenseType: expenseType)
          .then((value) => value.data);
    } catch (e) {
      rethrow;
    }
  }
}
