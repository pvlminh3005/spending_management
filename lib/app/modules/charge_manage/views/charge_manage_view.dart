import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/error_widget/error_widget.dart';
import '../../../widgets/icon_title.dart';
import '../../../widgets/list_loading_widget.dart';
import '../../../widgets/transaction_item.dart';
import '../controllers/charge_manage_controller.dart';

class ChargeManageView extends GetView<ChargeManageController> {
  const ChargeManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: InputCustom(
                    controller: controller.searchCtrl,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 8,
                    ),
                    hintText: 'Tìm kiếm',
                    hintStyle: context.caption.copyWith(fontSize: 14.sp),
                    isShowPrefixIcon: true,
                    isCountryPicker: true,
                    isSearch: true,
                    fillColor: context.tertiary,
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    borderSide: BorderSide.none,
                    onChanged: controller.searchData,
                  ),
                ),
                const SizedBox(width: 5),
                IconTitle(
                  iconData: Icons.filter_alt_rounded,
                  title: StringUtils.filter,
                  textStyle: context.caption.copyWith(fontSize: 12.sp),
                  onPressed: controller.toFilterPage,
                ),
              ],
            ),
          ),
          Obx(
            () => ColoredBox(
              color: context.secondary.withOpacity(.85),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Text(
                      controller.currentMonth < 10
                          ? '0${controller.currentMonth}/2022'
                          : '${controller.currentMonth}/2022',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.initData,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: double.infinity),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: controller.obx(
                    (state) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state!.length,
                        itemBuilder: (ctx, index) {
                          return TransactionItem(
                            model: state[index],
                            index: index,
                            tagColor: context.secondary,
                            onPressed: (transaction) => controller
                                .toDetailTransaction(transaction: transaction),
                            onLongPress: controller.confirmDeleteTransaction,
                          );
                        },
                      );
                    },
                    onLoading: const ListLoading(),
                    onEmpty: Obx(
                      () => SizedBox(
                        height: context.height * .5 + 180.h,
                        child: EmptyWidget(
                          title:
                              "Không có giao dịch trong tháng ${controller.currentMonth}",
                        ),
                      ),
                    ),
                    onError: (error) => const ErrorCustomWidget(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3.0,
        backgroundColor: context.secondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: controller.toDetailTransaction,
      ),
    );
  }
}
