import 'package:get/get.dart';
import '../../../core/styles/style.dart';
import '../../charge_manage/views/charge_manage_view.dart';
import '../../classify/views/classify_view.dart';
import '../../payment_manage/views/payment_manage_view.dart';
import '../../profile/views/profile_view.dart';

class DashboardController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  final pages = const [
    PaymentManageView(),
    ChargeManageView(),
    ClassifyView(),
    ProfileView(),
  ];
  final pageController = PageController();

  @override
  void onInit() {
    _currentIndex.listen((index) {
      pageController.jumpToPage(index);
    });
    super.onInit();
  }

  void onBottomTabChange(int index) => _currentIndex(index);

  @override
  void onClose() {
    pageController.dispose();
  }
}
