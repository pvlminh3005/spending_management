import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/constants/enum.dart';
import '../../../core/styles/style.dart';
import '../../../widgets/dropdown_custom.dart';
import '../controllers/classify_controller.dart';

class FilterTypeBuilder extends GetView<ClassifyController> {
  const FilterTypeBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          width: 110.0,
          child: Obx(
            () => DropDownCustom(
                categoryType: controller.classifyType,
                onChanged: controller.onChangedFilter),
          ),
        ),
      ),
    );
  }
}
