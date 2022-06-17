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
import '../../classify/controllers/classify_controller.dart';

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
  late TransactionType currentTransactionType;

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

  @override
  void onInit() {
    //* Get current transaction type
    currentTransactionType = Get.arguments[StringUtils.transactionTypeVal];

    UserService _userService = Get.find();

    List<CategoryModel> _list =
        currentTransactionType == TransactionType.payment
            ? _userService.listPaymentCategories
            : _userService.listChargeCategories;

    _listCategories(_list);
    _isDisable(_list.isEmpty);

    super.onInit();
  }

  @override
  void onReady() {
    initialData();
    super.onReady();
  }

  void initialData() {
    TransactionModel? arguments =
        Get.arguments[StringUtils.transactionModelVal];

    if (arguments != null) {
      _selectedDate = arguments.createdAt;
      _titleButton(StringUtils.updateTransaction);
      _uidTransaction = arguments.uid;
      dateController.text = arguments.formatDate;
      balanceController.text = arguments.displayBalance;
      descriptionController.text = arguments.description;
      for (var category in listCategories) {
        if (category.uid == arguments.category.uid) {
          _isDisable(false);
          _currentCategory(arguments.category);
          return;
        }
        _isDisable(true);
      }
      return;
    } else {
      _currentCategory(listCategories.first);
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
    WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
    if (formKey.currentState!.validate()) {
      _isLoading(true);
      try {
        final TransactionModel model = TransactionModel(
          uid: _uidTransaction,
          category: currentCategory!,
          balance: balanceStr.formatBalance,
          description: descriptionStr,
          transactionType: currentTransactionType,
          createdAt: _selectedDate,
        );
        TransactionModel? arguments =
            Get.arguments[StringUtils.transactionModelVal];
        if (arguments == null) {
          //* 1: new transaction
          await Repositories.transaction.createTransaction(model);
        } else {
          await Repositories.transaction.updateTransaction(data: model);
          //* First, we need decrement balance in previous category arguments pass
          await Repositories.classify.updateCurrentBalance(
            uidClassify: arguments.category.uid!,
            newBalance: arguments.balance,
            date: arguments.createdAt,
            isPlus: false,
          );
          //* Then, we update balance in current category
          await Repositories.classify.updateCurrentBalance(
            uidClassify: currentCategory!.uid!,
            newBalance: balanceStr.formatBalance,
            date: _selectedDate,
          );
        }
        _isLoading(false);
        //update data when occur change

        Get.back(result: true);
      } catch (e) {
        AppUtils.toast(e.toString());
        _isLoading(false);
      }
    }
  }

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
