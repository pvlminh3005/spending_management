import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/classify_controller.dart';

class TotalBalanceBuilder extends GetView<ClassifyController> {
  const TotalBalanceBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => TotalBalanceItem(
                    title: 'Tổng chi',
                    balance: controller.totalPayment,
                    icon: CupertinoIcons.down_arrow,
                    iconColor: context.error,
                  ),
                ),
                const SizedBox(height: 7),
                Obx(
                  () => TotalBalanceItem(
                    title: 'Tổng thu',
                    balance: controller.totalCharge,
                    icon: CupertinoIcons.up_arrow,
                    iconColor: context.secondary,
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () => Get.toNamed(Routes.classifyDetail),
            color: context.primary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  size: 24.sp,
                  color: Colors.white,
                ),
                const SizedBox(width: 3),
                Text(
                  'Báo cáo',
                  style: context.caption.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TotalBalanceItem extends StatelessWidget {
  final String title;
  final int balance;
  final IconData? icon;
  final Color? iconColor;
  final double? width;

  const TotalBalanceItem({
    required this.title,
    required this.balance,
    this.icon,
    this.iconColor,
    this.width = 70,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: width,
          child: Text(
            '$title:',
            style: context.bodyText1.copyWith(),
          ),
        ),
        if (icon != null)
          Icon(
            icon,
            size: 12,
            color: iconColor,
          ),
        if (balance != 0)
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(
                balance.format + ' ₫',
                style: context.bodyText2,
              ),
            ),
          ),
      ],
    );
  }
}
