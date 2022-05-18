import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/indicators/loading_indicator.dart';
import '../../../widgets/spending_manage_item.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: InputCustom(),
          ),
          Expanded(
            child: controller.obx(
              (state) {
                return ListView(
                  children: [
                    ColoredBox(
                      color: context.primary.withOpacity(.3),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            Text(
                              '05/2022',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...state!.asMap().entries.map((e) {
                      return SpendingManageItem(
                        model: state[e.key],
                        index: e.key,
                        tagColor: context.error,
                      );
                    }).toList(),
                  ],
                );
              },
              onLoading: const LoadingIndicator(),
              onEmpty: const Center(child: Text('No data found')),
              onError: (error) => Text(error!),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: context.error,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
