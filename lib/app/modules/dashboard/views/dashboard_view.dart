import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: controller.pages,
            controller: controller.pageController,
            allowImplicitScrolling: true,
          ),
        ),
        bottomNavigationBar: Obx(
          () => ColoredBox(
            color: context.background,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: context.screenPadding.bottom != 0 ? 10.w : 0,
              ),
              child: Row(
                children: [
                  _DashboardButton(
                    pathIcon: ImageUtils.expenseDownIcon,
                    title: 'Payment',
                    isActive: controller.currentIndex == 0,
                  ),
                  _DashboardButton(
                    pathIcon: ImageUtils.expenseUpIcon,
                    title: 'Charge',
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
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final String title;
  final String? pathIcon;
  final IconData? icon;
  final bool isActive;
  final int index;
  const _DashboardButton({
    required this.title,
    this.pathIcon,
    this.icon,
    this.isActive = true,
    this.index = 0,
    Key? key,
  }) : super(key: key);

  DashboardController get controller => Get.find();

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? context.primary : Colors.transparent;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 2.5,
                  color: color,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 8.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (pathIcon != null)
                    Image.asset(
                      pathIcon!,
                      width: 22.w,
                      height: 22.h,
                      fit: BoxFit.cover,
                    )
                  else
                    Icon(
                      icon,
                      size: 22.h,
                    ),
                  Dimensions.height5,
                  Text(
                    title,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ),
          onTap: () => controller.onBottomTabChange(index),
        ),
      ),
    );
  }
}
