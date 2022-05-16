import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/app/core/styles/style.dart';
import '../../../widgets/icon_title.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          children: controller.pages,
          controller: controller.pageController,
          allowImplicitScrolling: true,
        ),
        bottomNavigationBar: Obx(
          () => ColoredBox(
            color: context.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ColoredBox(
                color: context.background,
                child: Row(
                  children: [
                    _DashboardButton(
                      icon: Icons.pie_chart_rounded,
                      title: 'Text 1',
                      isActive: controller.currentIndex == 0,
                    ),
                    _DashboardButton(
                      icon: Icons.dynamic_form_sharp,
                      title: 'Text 2',
                      isActive: controller.currentIndex == 1,
                      index: 1,
                    ),
                    _DashboardButton(
                      icon: CupertinoIcons.person_solid,
                      title: 'Profile',
                      isActive: controller.currentIndex == 2,
                      index: 2,
                    )
                  ],
                ),
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
      child: IconTitle(
        title: title,
        iconData: icon,
        iconSize: 30,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        color: color,
        space: 10,
        onPressed: () => controller.onBottomTabChange(index),
      ),
    );
  }
}
