import 'package:get/get.dart';
import '../../../core/styles/style.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../routes/app_pages.dart';

class PaymentManageController extends GetxController
    with StateMixin<List<TransactionModel>>, ScrollMixin {
  final _currentMonth = DateTime.now().month.obs;
  final searchCtrl = TextEditingController();

  int _page = 1;
  int get currentMonth => _currentMonth.value;
  String get searchStr => searchCtrl.text;

  @override
  void onInit() {
    _currentMonth.listen((_) {
      getListTransactions();
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
    _page = 1;

    _currentMonth(DateTime.now().month);
    await getListTransactions();
  }

  Future<void> getListTransactions() async {
    try {
      var data = await Repositories.transaction.getTransactionPayment(
        page: _page,
        month: currentMonth,
      );
      change(
        data,
        status: data.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
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
      getListTransactions();
    } else {
      .5.delay(
        () {
          var data = state
              ?.where((e) => e.title.toLowerCase().contains(val.toLowerCase()))
              .toList();
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

  @override
  Future<void> onEndScroll() async {}

  @override
  Future<void> onTopScroll() async {}
}
