import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../widgets/common/app_button.dart';
import '../../../widgets/dotted_border/dotted_border.dart';
import '../controllers/classify_controller.dart';
import '../widgets/widgets.dart';

class ClassifyView extends GetView<ClassifyController> {
  const ClassifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.initialData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              StatisticalBuilder(),
              TotalBalanceBuilder(),
              FilterTypeBuilder(),
              ListClassifyBuilder(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: DottedBorder(
          radius: const Radius.circular(10.0),
          padding: EdgeInsets.zero,
          child: AppButton(
            'Thêm danh mục',
            fontSize: 15.sp,
            textColor: context.onBackground,
            color: context.background,
            elevation: 0,
            axisSize: MainAxisSize.max,
            onPressed: controller.createClassify,
          ),
        ),
      ),
    );
  }
}
