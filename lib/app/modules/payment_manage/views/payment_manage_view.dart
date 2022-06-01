import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/icon_title.dart';
import '../../../widgets/skeleton_loading/item_skeleton.dart';
import '../../../widgets/spending_manage_item.dart';
import '../controllers/payment_manage_controller.dart';

const _heightSkeleton = 25.0;
const _widthSkeleton = 90.0;

class PaymentManageView extends GetView<PaymentManageController> {
  const PaymentManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.initData,
      child: Scaffold(
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
              child: controller.obx(
                (state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state!.length,
                    itemBuilder: (ctx, index) {
                      return SpendingManageItem(
                        model: state[index],
                        index: index,
                        tagColor: context.error,
                        onPressed: () => controller.toDetailTransaction(
                            transaction: state[index]),
                      );
                    },
                  );
                },
                onLoading: const _ListLoading(),
                onEmpty: const EmptyWidget(),
                onError: (error) => Text(error!),
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
      ),
    );
  }
}

class _ListLoading extends StatelessWidget {
  const _ListLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (ctx, index) {
        return Container(
          color: index % 2 == 0
              ? context.background
              : context.tertiary.withOpacity(.6),
          padding: EdgeInsets.symmetric(
            vertical: 11.h,
            horizontal: 7.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ItemLoading(
                width: _widthSkeleton - 20,
                height: _heightSkeleton,
              ),
              SizedBox(height: 5.h),
              const ItemLoading(
                width: double.infinity,
                height: 90,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ItemLoading(
                    width: _widthSkeleton,
                    height: _heightSkeleton,
                  ),
                  ItemLoading(
                    width: _widthSkeleton + _heightSkeleton,
                    height: _heightSkeleton,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// class _CardAmountBuilder extends StatelessWidget {
//   final String title;
//   final int amount;
//   final TextStyle? style;
//   const _CardAmountBuilder({
//     this.title = '',
//     this.amount = 0,
//     this.style,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       shape: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(6.w),
//         borderSide: BorderSide.none,
//       ),
//       shadowColor: Colors.black26,
//       child: SizedBox(
//         width: context.width * .45,
//         child: Center(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 5.h,
//                   horizontal: 8.w,
//                 ),
//                 child: Text(
//                   title,
//                   style: context.bodyText1.copyWith(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                 ),
//               ),
//               const Divider(height: 0),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: 7.h,
//                   horizontal: 8.w,
//                 ),
//                 child: Text(
//                   '${amount.format} đ',
//                   style: style ?? context.bodyText1,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
