import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../data/models/expense/expense.dart';
import '../../../data/repositories/repositories.dart';

class ChargeManageController extends GetxController
    with StateMixin<List<ExpenseModel>> {
  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    change(state, status: RxStatus.loading());
    try {
      var data =
          await Repositories.expense.getList(expenseType: ExpenseType.charge);
      change(data, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      rethrow;
    }
  }
}
