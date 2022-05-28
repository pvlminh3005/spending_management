import 'package:get/get.dart';
import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../data/models/expense/expense.dart';
import '../../../data/repositories/repositories.dart';
import '../../../routes/app_pages.dart';

class PaymentManageController extends GetxController
    with StateMixin<List<ExpenseModel>> {
  final _currentMonth = Rx<int>(DateTime.now().month);
  int get currentMonth => _currentMonth.value;

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
      var data =
          await Repositories.expense.getList(expenseType: ExpenseType.payment);
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
    _currentMonth(data ?? currentMonth);
  }

  Future<void> searchData(String val) async {
    if (val.isEmpty) {
      initData();
    } else {
      change(state, status: RxStatus.loading());
      1.delay(() {
        var data = state?.where((e) => e.title.contains(val)).toList();
        if (data == null) {
          change(state, status: RxStatus.error());
        } else if (data.isEmpty) {
          change([], status: RxStatus.empty());
        } else {
          change(data, status: RxStatus.success());
        }
      });
    }
  }

  @override
  void onClose() {
    searchCtrl.dispose();
  }
}
