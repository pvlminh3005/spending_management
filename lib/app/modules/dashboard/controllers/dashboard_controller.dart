import 'package:get/get.dart';
import '../../../core/styles/style.dart';
import '../../paybook/views/paybook_view.dart';
import '../../revenue_expenditure/views/revenue_expenditure_view.dart';

class DashboardController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  final pages = const [
    PaybookView(),
    RevenueExpenditureView(),
  ];
  final pageController = PageController();

  @override
  void onInit() {
    _currentIndex.listen((index) {
      pageController.animateToPage(
        index,
        curve: Curves.fastOutSlowIn,
        duration: kTabScrollDuration,
      );
    });
    super.onInit();
  }

  void onBottomTabChange(int index) => _currentIndex(index);

  @override
  void onClose() {
    pageController.dispose();
  }
}
