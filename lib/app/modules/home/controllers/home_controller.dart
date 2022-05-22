import 'package:get/get.dart';
import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../data/models/expense_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController
    with StateMixin<List<ExpenseModel>> {
  final _currentMonth = Rx<int?>(null);
  int? get currentMonth => _currentMonth.value;

  final searchCtrl = TextEditingController();
  String get searchStr => searchCtrl.text;

  @override
  void onInit() {
    initData();

    _currentMonth.listen((_) {
      initData();
    });
    super.onInit();
  }

  Future<void> initData() async {
    try {
      var data = await Repositories.expense
          .getList(expenseType: ExpenseType.payment.index);
      if (data.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error());
      rethrow;
    }
  }

  Future<void> toFilterPage() async {
    var data = await Get.toNamed(
      Routes.filter,
      arguments: currentMonth,
    );
    _currentMonth(data);
  }

  @override
  void onClose() {
    searchCtrl.dispose();
  }
}
