import 'package:get/get.dart';

import '../../../core/styles/style.dart';
import '../../../widgets/dropdown_custom.dart';
import '../controllers/classify_controller.dart';
import 'total_balance_builder.dart';

class FilterTypeBuilder extends GetView<ClassifyController> {
  const FilterTypeBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 10.0,
        top: 10.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => TotalBalanceItem(
                title: 'Tổng ước tính',
                balance: controller.totalEstimate,
                icon: Icons.label_important,
                iconColor: const Color(0xFFe67e22),
                width: Get.width > 600 ? 100.w : 100,
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 100.w,
            child: Obx(
              () => DropDownCustom(
                categoryType: controller.classifyType,
                onChanged: controller.onChangedFilter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
