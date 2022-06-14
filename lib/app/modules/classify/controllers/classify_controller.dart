import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/classify_model.dart';
import '../../../data/repositories/repositories.dart';

class ClassifyController extends GetxController
    with StateMixin<List<ClassifyModel>>, ScrollMixin {
  final List<ClassifyModel> listClassify = [];
  final _listClassifyPayment = <ClassifyModel>[].obs;
  final _listClassifyCharge = <ClassifyModel>[].obs;
  final _classifyType = CategoryType.payment.obs;
  final _sortAscending = false.obs;
  final _totalPayment = 0.obs;
  final _totalCharge = 0.obs;
  final int balanceLast = 120000;

  List<ClassifyModel> get listClassifyPayment => _listClassifyPayment;
  List<ClassifyModel> get listClassifyCharge => _listClassifyCharge;
  CategoryType get classifyType => _classifyType.value;
  bool get sortAscending => _sortAscending.value;
  int get totalPayment => _totalPayment.value;
  int get totalCharge => _totalCharge.value;

  @override
  void onInit() {
    _classifyType.listen((_) {
      getListClassify();
    });
    super.onInit();
  }

  @override
  void onReady() {
    initialData();
    super.onReady();
  }

  Future<void> initialData() async {
    try {
      resetData();
      var data = await Repositories.classify.getListClassify();
      listClassify.addAll(data);

      for (var classify in data) {
        if (classify.type == CategoryType.payment) {
          _totalPayment(totalPayment + classify.currentBalance);
        } else {
          _totalCharge(totalCharge + classify.currentBalance);
        }
      }

      await getListClassify();
    } catch (e) {
      change(null, status: RxStatus.error());
    }
  }

  Future<void> getListClassify() async {
    List<ClassifyModel> data = listClassify
        .where((classify) => classify.type == classifyType)
        .toList();
    change(
      data,
      status: data.isEmpty ? RxStatus.empty() : RxStatus.success(),
    );
  }

  void sortList(int columnIndex, bool ascending) {
    _sortAscending(ascending);
    if (ascending) {
      state!.sort((model1, model2) => model1.title.compareTo(model2.title));
    } else {
      state!.sort((model1, model2) => model2.title.compareTo(model1.title));
    }
  }

  void onChangedFilter(CategoryType? newType) => _classifyType(newType);

  void createClassify() {
    LayoutUtils.openBottomSheet(
      onPressed: (ClassifyModel data) async {
        await Repositories.classify.createClassify(data);
        Get
          ..back()
          ..back();
      },
    );
  }

  void onEditClassify(ClassifyModel classify) {
    LayoutUtils.openBottomSheet(
      isEdit: true,
      classify: classify,
      onPressed: (_) {},
      onDelete: () {},
    );
  }

  void resetData() {
    listClassify.clear();
    _sortAscending(false);
    _totalPayment(0);
    _totalCharge(0);
  }

  @override
  Future<void> onEndScroll() async {}

  @override
  Future<void> onTopScroll() async {}
}
