import 'package:get/get.dart';

import '../../../core/utilities/utilities.dart';
import '../../../data/models/category_model.dart';
import '../../../data/services/user_service.dart';

class FilterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _listCategories = <CategoryModel>[].obs;
  final _currentCategory = Rxn<CategoryModel>(null);
  final _isLoading = false.obs;
  final _currentMonth = (DateTime.now().month).obs;

  List<CategoryModel> get listCategories => _listCategories;
  bool get isLoading => _isLoading.value;
  int get currentMonth => _currentMonth.value;
  CategoryModel? get currentCategory => _currentCategory.value;

  @override
  void onInit() {
    _listCategories(Get.find<UserService>().listPaymentCategories);
    if (listCategories.isNotEmpty) {
      _currentCategory.value = listCategories.first;
    }
    _currentMonth((Get.arguments[StringUtils.monthVal] as int) - 1);

    super.onInit();
  }

  Future<void> applyFilter(int index) async {
    int newMonth = index + 1;
    _currentMonth(newMonth);
    Get.back(result: currentMonth);
  }
}
