import 'package:get/get.dart';
import '../../../core/styles/style.dart';
import '../../../data/models/transaction/transaction.dart';
import '../../../data/repositories/repositories.dart';
import '../../../routes/app_pages.dart';

class PaymentManageController extends GetxController
    with StateMixin<List<TransactionModel>> {
  final _currentMonth = Rx<int>(DateTime.now().month);
  final searchCtrl = TextEditingController();

  int get currentMonth => _currentMonth.value;
  String get searchStr => searchCtrl.text;

  @override
  void onInit() {
    _currentMonth.listen((_) {
      initData();
    });
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  void toDetailTransaction({TransactionModel? transaction}) {
    Get.toNamed(
      Routes.transactionDetail,
      arguments: transaction,
    );
  }

  Future<void> initData() async {
    try {
      var transaction = await Repositories.transaction.getListPayment();
      final data = transaction.listTransactions;
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
      1.delay(
        () {
          var data = state?.where((e) => e.title.contains(val)).toList();
          if (data == null) {
            change(state, status: RxStatus.error());
          } else if (data.isEmpty) {
            change([], status: RxStatus.empty());
          } else {
            change(data, status: RxStatus.success());
          }
        },
      );
    }
  }

  @override
  void onClose() {
    searchCtrl.dispose();
  }
}
