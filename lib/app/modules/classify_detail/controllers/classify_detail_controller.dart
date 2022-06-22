import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../core/utilities/app_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/classify_model.dart';
import '../../../data/repositories/repositories.dart';

class ClassifyDetailController extends GetxController
    with StateMixin<List<ClassifyModel>> {
  final List<ClassifyModel> listClassify = [];
  final _classifyType = CategoryType.payment.obs;

  CategoryType get classifyType => _classifyType.value;

  @override
  void onInit() {
    _classifyType.listen((_) {
      getListClassify();
    });
    super.onInit();
  }

  Future<void> getListClassifyDB(DateTime date) async {
    change(state, status: RxStatus.loading());
    try {
      clearData();
      var data = await Repositories.classify.getListClassify(date: date);
      listClassify.addAll(data);
      await getListClassify();
    } catch (e) {
      change(null, status: RxStatus.error());
      AppUtils.toast(e.toString());
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

  Future<void> toggleItem(DateTime date) async {
    LayoutUtils.openSheetClassify(date);
    await getListClassifyDB(date);
  }

  void onChangedFilter(CategoryType? newType) => _classifyType(newType);

  void onCloseDialog() {
    Get.back();
  }

  void clearData() {
    _classifyType(CategoryType.payment);
    listClassify.clear();
    change(listClassify, status: RxStatus.success());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
