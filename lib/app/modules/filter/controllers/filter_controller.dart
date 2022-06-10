import 'package:get/get.dart';

class FilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _currentMonth = (DateTime.now().month).obs;
  int get currentMonth => _currentMonth.value;

  @override
  void onInit() {
    _currentMonth((Get.arguments as int) - 1);
    super.onInit();
  }

  Future<void> applyFilter(int index) async {
    int newMonth = index + 1;
    _currentMonth(newMonth);
    Get.back(result: currentMonth);
  }

  @override
  void onClose() {}
}
