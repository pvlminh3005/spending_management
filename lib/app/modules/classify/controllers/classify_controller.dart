import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../core/utilities/app_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/classify_model.dart';
import '../../../data/repositories/repositories.dart';

class ClassifyController extends GetxController with ScrollMixin {
  final listClassify = <ClassifyModel>[].obs;
  final listClassifyType = <ClassifyModel>[].obs;
  final _classifyType = CategoryType.payment.obs;
  final _loadingTable = false.obs;
  final _sortAscending = false.obs;
  final _totalPayment = 0.obs;
  final _totalCharge = 0.obs;
  final _totalEstimate = 0.obs;
  final _openingBalance = 0.obs;
  final _endingBalance = 0.obs;

  CategoryType get classifyType => _classifyType.value;
  bool get loadingTable => _loadingTable.value;
  bool get sortAscending => _sortAscending.value;
  int get totalPayment => _totalPayment.value;
  int get totalCharge => _totalCharge.value;
  int get totalEstimate => _totalEstimate.value;
  int get openingBalance => _openingBalance.value;
  int get endingBalance => _endingBalance.value;

  @override
  void onInit() {
    initialData().whenComplete(() {
      Repositories.classify.streamListClassify().listen((event) {
        if (event.docChanges.length == listClassify.length) return;

        ClassifyModel classify =
            ClassifyModel.fromJson(event.docChanges.first.doc.data()!);

        print(classify.defaultBalance);
        if (classify.uid == null) return;

        int _index =
            listClassify.indexWhere((element) => element.uid == classify.uid);
        if (_index >= 0) {
          calculatorTotal(
            preClassify: listClassify[_index],
            newClassify: classify,
          );
          listClassify[_index] = classify;
        } else {
          print('ADDED');
          listClassify.insert(0, classify);
          calculatorTotal(newClassify: classify);
        }
        getListClassify.call();
      });
    });

    _classifyType.listen((_) {
      getListClassify.call();
    });

    super.onInit();
  }

  Future<void> initialData() async {
    _loadingTable(true);
    resetData();
    try {
      var data = await Repositories.classify.getListClassify();
      _openingBalance(await Repositories.classify.getOpeningBalance());

      listClassify.addAll(data);

      for (var classify in data) {
        calculatorTotal(newClassify: classify);
      }

      getListClassify.call();
    } catch (e) {
      AppUtils.toast(e.toString());
    } finally {
      _loadingTable(false);
    }
  }

  void calculatorTotal({
    ClassifyModel? preClassify,
    required ClassifyModel newClassify,
  }) {
    int _default = preClassify?.defaultBalance ?? 0;
    int _current = preClassify?.currentBalance ?? 0;

    _totalEstimate(totalEstimate - _default + newClassify.defaultBalance);
    if (newClassify.type == CategoryType.payment) {
      _totalPayment(totalPayment - _current + newClassify.currentBalance);
    } else {
      _totalCharge(totalCharge - _current + newClassify.currentBalance);
    }
    _endingBalance(totalCharge - totalPayment + openingBalance);
  }

  void removeItem(ClassifyModel classify) {
    classify = classify.copyWith(
      currentBalance: -classify.currentBalance,
      defaultBalance: -classify.defaultBalance,
    );
    listClassify.removeWhere((e) => e.uid == classify.uid);
    calculatorTotal(newClassify: classify);
  }

  List<ClassifyModel> getListClassify() {
    print('CALLED');
    return listClassify
        .where((element) => element.type == classifyType)
        .toList();
  }

  void sortList(int columnIndex, bool ascending) {
    _sortAscending(ascending);
    if (ascending) {
      listClassify.sort(
        (model1, model2) => model1.title.compareTo(model2.title),
      );
    } else {
      listClassify.sort(
        (model1, model2) => model2.title.compareTo(model1.title),
      );
    }
  }

  void onChangedFilter(CategoryType? newType) => _classifyType(newType);

  void createClassify() {
    LayoutUtils.openBottomSheet(
      onCreate: (ClassifyModel data) async {
        var existData =
            listClassify.where((element) => element.title == data.title);

        if (existData.isEmpty) {
          await Repositories.classify.createClassify(data);
          Get.back(closeOverlays: true);
        } else {
          AppUtils.toast('Tên danh mục đã tồn tại');
        }
      },
    );
  }

  void onEditClassify(ClassifyModel classify) {
    LayoutUtils.openBottomSheet(
      isEdit: true,
      classify: classify,
      onEdit: (ClassifyModel classify) async {
        await Repositories.classify.updateClassify(classify);
        Get
          ..back()
          ..back();
      },
      onDelete: () async {
        LayoutUtils.dialogMessage(
          title: 'Bạn muốn xoá danh mục này?',
          subtitle: 'Các giao dịch liên quan tới danh mục này đều không bị xoá',
          onConfirm: () async {
            try {
              await Repositories.classify.deleteClassify(classify);
              removeItem(classify);
              Get.back(closeOverlays: true);
              AppUtils.toast('Xoá danh mục thành công');
            } catch (e) {
              AppUtils.toast(e.toString());
              await 1.delay(Get.back);
            }
          },
        );
      },
    );
  }

  void resetData() {
    listClassify.clear();
    _sortAscending(false);
    _totalPayment(0);
    _totalCharge(0);
    _totalEstimate(0);
  }

  @override
  Future<void> onEndScroll() async {}

  @override
  Future<void> onTopScroll() async {}
}
