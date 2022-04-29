import 'package:get/get.dart';

import '../../../widgets/icon_title.dart';
import '/app/core/styles/style.dart';
import '/app/widgets/common/appbar_custom.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarCustom(
            title: 'Chỉnh sửa tài khoản',
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: controller.pages,
            controller: controller.pageController,
            allowImplicitScrolling: true,
          ),
          bottomNavigationBar: Obx(
            () => ColoredBox(
              color: Colors.white,
              child: Row(
                children: [
                  _DashboardButton(
                    icon: Icons.contacts_sharp,
                    title: 'Sổ nợ',
                    isActive: controller.currentIndex == 0,
                  ),
                  _DashboardButton(
                    icon: Icons.swap_vert,
                    title: 'Thu chi',
                    isActive: controller.currentIndex == 1,
                    index: 1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final int index;
  const _DashboardButton({
    required this.title,
    required this.icon,
    this.isActive = true,
    this.index = 0,
    Key? key,
  }) : super(key: key);

  DashboardController get controller => Get.find();

  @override
  Widget build(BuildContext context) {
    final color = isActive ? context.primary : Colors.grey;
    return Expanded(
      child: SizedBox(
        width: 50.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
              top: BorderSide(
                color: isActive ? color : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: IconTitle(
            title: title,
            iconData: icon,
            color: color,
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            onPressed: () => controller.onBottomTabChange(index),
          ),
        ),
      ),
    );
  }
}
