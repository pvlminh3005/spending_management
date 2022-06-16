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
import '../controllers/payment_manage_controller.dart';

class PaymentManageView extends GetView<PaymentManageController> {
  const PaymentManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Expanded(
                  child: InputCustom(
                    controller: controller.searchCtrl,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 13.h,
                      horizontal: 8.w,
                    ),
                    hintText: 'Tìm kiếm',
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
                SizedBox(width: 5.w),
                IconTitle(
                  iconData: Icons.filter_alt_rounded,
                  title: StringUtils.filter,
                  onPressed: controller.toFilterPage,
                ),
              ],
            ),
          ),
          Obx(
            () => ColoredBox(
              color: context.primary.withOpacity(.3),
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    Text(
                      controller.currentMonth < 10
                          ? '0${controller.currentMonth}/2022'
                          : '${controller.currentMonth}/2022',
                      style: TextStyle(
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
              child: controller.obx(
                (state) {
                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state!.length,
                    itemBuilder: (ctx, index) {
                      return TransactionItem(
                        model: state[index],
                        index: index,
                        tagColor: context.error,
                        onPressed: (transaction) => controller
                            .toDetailTransaction(transaction: transaction),
                        onLongPress: (_) =>
                            controller.confirmDeleteTransaction(state[index]),
                      );
                    },
                  );
                },
                onLoading: const ListLoading(),
                onEmpty: Obx(
                  () => EmptyWidget(
                      title:
                          "Không có giao dịch trong tháng ${controller.currentMonth}"),
                ),
                onError: (error) => const ErrorCustomWidget(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3.0,
        backgroundColor: context.error,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: controller.toDetailTransaction,
      ),
    );
  }
}
