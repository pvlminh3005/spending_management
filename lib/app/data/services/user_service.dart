import 'package:get/get.dart';

import '../../core/constants/enum.dart';
import '../../core/utilities/app_utils.dart';
import '../models/category_model.dart';
import '../repositories/repositories.dart';

class UserService extends GetxService {
  final _listPaymentCategories = <CategoryModel>[].obs;
  final _listChargeCategories = <CategoryModel>[].obs;

  List<CategoryModel> get listPaymentCategories => _listPaymentCategories;
  List<CategoryModel> get listChargeCategories => _listChargeCategories;
  Future<UserService> init() async {
    _listPaymentCategories(
      await Repositories.category.getCategories(type: CategoryType.payment),
    );
    _listChargeCategories(
      await Repositories.category.getCategories(type: CategoryType.charge),
    );

    await checkCurrentMonth();
    return this;
  }

  Future<void> checkCurrentMonth() async {
    try {
      await Repositories.classify
          .resetCurrentBalanceClassify(DateTime.now().month);
    } catch (e) {
      AppUtils.toast(e.toString());
    }
  }
}
