import 'package:get/get.dart';

import '../../core/constants/enum.dart';
import '../models/category_model.dart';
import '../repositories/repositories.dart';

class UserService extends GetxService {
  final _listPaymentCategories = Rx<List<CategoryModel>>([]);
  final _listChargeCategories = Rx<List<CategoryModel>>([]);

  List<CategoryModel> get listPaymentCategories => _listPaymentCategories.value;
  // List<CategoryModel> get lisChargeCategories => _lisChargeCategories.value;

  Future<UserService> init() async {
    _listPaymentCategories(
        await Repositories.category.getCategories(type: CategoryType.payment));

    // _listChargeCategories(
    //     await Repositories.category.getCategories(type: CategoryType.charge));

    return this;
  }
}
