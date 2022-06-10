import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../core/utilities/app_utils.dart';
import '../../../core/utilities/date_time_picker_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../data/services/user_service.dart';
import '../../../routes/app_pages.dart';

enum ButtonDetailType {
  create,
  update,
  delete,
}

final _currentDate = DateTime.now().displayDate;

class TransactionDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _isLoading = false.obs;
  final dateController = TextEditingController(text: _currentDate);
  final balanceController = TextEditingController();
  final descriptionController = TextEditingController();
  final _listCategories = <CategoryModel>[].obs;

  bool get isLoading => _isLoading.value;
  String get dateStr => dateController.text;
  String get balanceStr => balanceController.text;
  String get descriptionStr => descriptionController.text;
  String titleButton = StringUtils.createTransaction;
  List<CategoryModel> get listCategories => _listCategories;
  //?

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initialData();
    super.onReady();
  }

  void initialData() {
    _listCategories(Get.find<UserService>().lisPaymentCategories);
    TransactionModel? arguments = Get.arguments;

    if (arguments != null) {
      titleButton = StringUtils.updateTransaction;
      dateController.text = arguments.formatDate;
      balanceController.text = arguments.displayBalance;
      descriptionController.text = arguments.description ?? '';
    }
  }

  void chooseDate(BuildContext context) {
    DateTimePickerUtils.dateTimePicker(
      initialDate: DateTimeExt.parseDate(dateStr),
    ).then((date) {
      if (date != null) {
        dateController.text = date.displayDate;
      }
    });
  }

  Future<void> createTransaction() async {
    if (formKey.currentState!.validate()) {
      _isLoading(true);
      try {
        final TransactionModel model = TransactionModel(
          uid: const Uuid().v1(),
          title: 'Test 1',
          balance: balanceStr.formatBalance,
          description: descriptionStr,
          transactionType: TransactionType.payment,
          createdAt: DateTimeExt.parseDate(dateStr),
        );

        await Repositories.transaction.createTransaction(model);
        _isLoading(false);
        Get.offAndToNamed(Routes.dashboard);
      } catch (e) {
        AppUtils.toast(e.toString());
        _isLoading(false);
      }
    }
  }

  @override
  void onClose() {
    dateController.dispose();
    balanceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
