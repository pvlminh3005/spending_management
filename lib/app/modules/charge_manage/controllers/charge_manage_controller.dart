import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/providers/providers.dart';
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
      var data = await Repositories.expense
          .getList(expenseType: ExpenseType.charge.index);
      change(data, status: RxStatus.success());
    } catch (e) {
      rethrow;
    }
  }
}
