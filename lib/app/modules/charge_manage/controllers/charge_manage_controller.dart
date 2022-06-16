import 'package:get/get.dart';
import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../core/utilities/layout_utils.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../filter/navigator/navigator.dart';
import '../../transaction_detail/navigator/navigator.dart';

class ChargeManageController extends GetxController
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
    TransactionDetailNavigator.toTransactionDetail(args: transaction)
        ?.then((value) {
      if (value) {
        getListTransactions();
      }
    });
  }

  void confirmDeleteTransaction(String uid) {
    try {
      LayoutUtils.dialogMessage(
          title: 'Bạn có muốn xoá giao dịch này?',
          onConfirm: () async {
            // await Repositories.transaction.deleteTransaction(
            //   type: TransactionType.charge,
            //   uidTransaction: uid,
            // );
            // state!.removeWhere((transaction) => transaction.uid == uid);
            // change(
            //   state,
            //   status: state!.isNotEmpty ? RxStatus.success() : RxStatus.empty(),
            // );
          });
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> initData() async {
    _page = 1;

    _currentMonth(DateTime.now().month);
    await getListTransactions();
  }

  Future<void> getListTransactions() async {
    try {
      var data = await Repositories.transaction.getTransactionCharge(
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
    FilterNavigator.toFilter(
      month: currentMonth,
      type: CategoryType.charge,
    )?.then((newMonth) {
      _currentMonth(newMonth ?? currentMonth);
    });
  }

  Future<void> searchData(String val) async {
    if (val.isEmpty) {
      getListTransactions();
    } else {
      .5.delay(
        () {
          var data = state
              ?.where((e) => e.title.tiengViet.contains(val.tiengViet))
              .toList();
          if (data == null) {
            change(state, status: RxStatus.error());
          } else {
            change(
              data,
              status: data.isNotEmpty ? RxStatus.success() : RxStatus.empty(),
            );
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
