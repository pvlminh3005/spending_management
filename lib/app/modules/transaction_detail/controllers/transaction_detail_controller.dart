import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../core/utilities/app_utils.dart';
import '../../../core/utilities/date_time_picker_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/repositories.dart';
import '../../../data/services/user_service.dart';

class TransactionDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _titleButton = StringUtils.createTransaction.obs;
  final _isLoading = false.obs;
  final _isDisable = false.obs;
  final dateController =
      TextEditingController(text: DateTime.now().displayDate);
  final balanceController = TextEditingController();
  final descriptionController = TextEditingController();
  final _listCategories = <CategoryModel>[].obs;
  final _currentCategory = Rxn<CategoryModel>(null);

  String? _uidTransaction;
  DateTime _selectedDate = DateTime.now();
  bool get isLoading => _isLoading.value;
  bool get isDisable => _isDisable.value;
  String get dateStr => dateController.text;
  String get balanceStr => balanceController.text;
  String get descriptionStr => descriptionController.text;
  String get titleButton => _titleButton.value;
  List<CategoryModel> get listCategories => _listCategories;
  CategoryModel? get currentCategory => _currentCategory.value;
  //?

  @override
  void onInit() {
    List<CategoryModel> _list = Get.find<UserService>().listPaymentCategories;
    _listCategories(_list);

    if (_list.isNotEmpty) {
      _currentCategory.value = _list.first;
    }

    super.onInit();
  }

  @override
  void onReady() {
    initialData();
    super.onReady();
  }

  void initialData() {
    TransactionModel? arguments = Get.arguments;

    if (arguments != null) {
      _selectedDate = arguments.createdAt;
      _titleButton(StringUtils.updateTransaction);
      _uidTransaction = arguments.uid;
      dateController.text = arguments.formatDate;
      balanceController.text = arguments.displayBalance;
      descriptionController.text = arguments.description ?? '';
      for (var category in listCategories) {
        if (!category.uid!.contains(arguments.category.uid!)) {
          _isDisable(true);
        }
      }
      _currentCategory(arguments.category);
    }
  }

  void chooseDate(BuildContext context) {
    DateTimePickerUtils()
        .dateTimePicker(initialDate: DateTimeExt.parseDate(dateStr))
        .then((date) {
      if (date != null) {
        updateDate(date);
      }
    });
  }

  void selectedCategory(CategoryModel category) => _currentCategory(category);

  Future<void> toggleTransaction() async {
    if (formKey.currentState!.validate()) {
      _isLoading(true);
      try {
        final TransactionModel model = TransactionModel(
          uid: _uidTransaction,
          category: currentCategory!,
          balance: balanceStr.formatBalance,
          description: descriptionStr,
          transactionType: TransactionType.payment,
          createdAt: _selectedDate,
        );
        if (Get.arguments == null) {
          await Repositories.transaction.createTransaction(model);
        } else {
          await Repositories.transaction.updateTransaction(data: model);
        }

        _isLoading(false);
        Get.back(result: true);
      } catch (e) {
        AppUtils.toast(e.toString());
        _isLoading(false);
      }
    }
  }

  Future<void> updateTransaction() async {}

  void updateDate(DateTime newDate) {
    _selectedDate = newDate;
    dateController.text = newDate.displayDate;
  }

  @override
  void onClose() {
    dateController.dispose();
    balanceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
