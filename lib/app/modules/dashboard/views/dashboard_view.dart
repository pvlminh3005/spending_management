// ignore_for_file: unused_element

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
          ),
        ),
        bottomNavigationBar: ColoredBox(
          color: context.background,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: context.screenPadding.bottom != 0 ? 10.w : 0,
            ),
            child: Row(
              children: [
                _DashboardButton(
                  pathIcon: ImageUtils.expenseDownIcon,
                  title: 'Khoản chi',
                  index: 0,
                ),
                _DashboardButton(
                  pathIcon: ImageUtils.expenseUpIcon,
                  title: 'Khoản thu',
                  index: 1,
                ),
                _DashboardButton(
                  pathIcon: ImageUtils.classifyIcon,
                  title: 'Phân loại',
                  index: 2,
                ),
                _DashboardButton(
                  pathIcon: ImageUtils.userIcon,
                  title: 'Cá nhân',
                  index: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardButton extends GetView<DashboardController> {
  final String title;
  final String? pathIcon;
  final IconData? icon;
  final int index;
  const _DashboardButton({
    required this.title,
    required this.index,
    this.pathIcon,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final Color color = controller.currentIndex == index ? context.primary : Colors.transparent;
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
                        )
                      else
                        Icon(
                          icon,
                          size: 22.h,
                        ),
                      Dimensions.height5,
                      Text(
                        title,
                        style: context.caption.copyWith(
                          fontSize: 12.sp,
                          fontWeight: controller.currentIndex == index ? FontWeight.bold : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () => controller.onBottomTabChange(index),
            ),
          ),
        );
      },
    );
  }
}
