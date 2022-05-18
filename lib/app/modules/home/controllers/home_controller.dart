import 'package:get/get.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/providers/providers.dart';

class HomeController extends GetxController
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
          await ExpenseProvider.getList(expenseType: ExpenseType.payment.index);
      change(data, status: RxStatus.success());
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {}
}
