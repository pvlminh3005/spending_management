import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/common/appbar_custom.dart';
import '../controllers/filter_controller.dart';
import '../widgets/list_month.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentFilter = ValueNotifier<int>(controller.currentMonth);

    return Scaffold(
      appBar: AppBarCustom(
        title: StringUtils.filter,
        backgroundColor: context.primary,
        color: Colors.white,
        style: TextStyle(color: context.background),
        showNotification: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: _currentFilter,
              builder: (BuildContext context, int value, Widget? _) {
                return ListMonthWidget(
                  currentMonth: value,
                  onSelected: (int newMonth) {
                    _currentFilter.value = newMonth;
                  },
                );
              },
            ),
            // const SizedBox(height: 20),
            // ListClassifyTitleWidget(
            //   listCategories: controller.listCategories,
            //   isTapToDisable: true,
            //   selectedColor: context.primary,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => AppButton(
            StringUtils.apply,
            axisSize: MainAxisSize.max,
            loading: controller.isLoading,
            onPressed: () => controller.applyFilter(_currentFilter.value),
          ),
        ),
      ),
    );
  }
}
