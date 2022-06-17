import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../controllers/classify_controller.dart';

class StatisticalBuilder extends GetView<ClassifyController> {
  const StatisticalBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Row(
        children: [
          Obx(
            () => _StatisticalItem(
              title: 'Số dư đầu kỳ',
              balance: controller.openingBalance,
              color: context.theme.brightness == Brightness.light
                  ? const Color(0xFF334960)
                  : context.onBackground,
            ),
          ),
          ColoredBox(
            color: context.tertiary,
            child: const SizedBox(width: 1, height: 100.0),
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

  const _StatisticalItem({
    required this.title,
    required this.balance,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    balance.format + '\t₫',
                    style: context.bodyText1.copyWith(
                      fontSize: 15,
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
    );
  }
}
