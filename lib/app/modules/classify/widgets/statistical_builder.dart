import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../controllers/classify_controller.dart';

class StatisticalBuilder extends GetView<ClassifyController> {
  const StatisticalBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Row(
        children: [
          Obx(
            () => _StatisticalItem(
              title: 'Số dư đầu kỳ',
              balance: controller.openingBalance,
              color: context.theme.brightness == Brightness.light
                  ? const Color(0xFF334960)
                  : context.onBackground,
              onTap: LayoutUtils.editOpeningBalance,
            ),
          ),
          ColoredBox(
            color: context.tertiary,
            child: SizedBox(
              width: 1,
              height: 80.h,
            ),
          ),
          Obx(
            () => _StatisticalItem(
              title: 'Số dư cuối kỳ',
              balance: controller.endingBalance,
              color: controller.endingBalance < 0
                  ? context.error
                  : context.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatisticalItem extends StatelessWidget {
  final String title;
  final int balance;
  final Color? color;
  final VoidCallback? onTap;

  const _StatisticalItem({
    required this.title,
    required this.balance,
    this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: ColoredBox(
          color: context.tertiary.withOpacity(.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: context.bodyText1.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      balance.format + ' ₫',
                      style: context.bodyText1.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
