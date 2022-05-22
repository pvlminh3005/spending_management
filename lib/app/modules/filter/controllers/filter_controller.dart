import 'package:get/get.dart';

class FilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _currentMonth = Rxn<int?>(null);
  int? get currentMonth => _currentMonth.value;

  @override
  void onInit() {
    _currentMonth(Get.arguments);
    super.onInit();
  }

  Future<void> applyFilter(int? index) async {
    _currentMonth(index);
    _isLoading(true);
    await 2.delay(() {
      Get.back(result: currentMonth);
    });
    _isLoading(false);
  }

  @override
  void onClose() {}
}
