import 'package:get/get.dart';
import '../../../core/styles/style.dart';
import '../../charge_manage/views/charge_manage_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class DashboardController extends GetxController {
  final _currentIndex = 0.obs;
  int get currentIndex => _currentIndex.value;
  final pages = const [
    HomeView(),
    ChargeManageView(),
    ProfileView(),
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
