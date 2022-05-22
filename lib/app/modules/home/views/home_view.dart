import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/common/input_custom.dart';
import '../../../widgets/icon_title.dart';
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
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                SizedBox(width: 5.w),
                IconTitle(
                  iconData: Icons.filter_alt_rounded,
                  title: 'Bộ lọc',
                  onPressed: controller.toFilterPage,
                ),
              ],
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) {
                return RefreshIndicator(
                  onRefresh: controller.initData,
                  child: ListView(
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
                  ),
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
        elevation: 3.0,
        backgroundColor: context.error,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}

class _CardAmountBuilder extends StatelessWidget {
  final String title;
  final int amount;
  final TextStyle? style;
  const _CardAmountBuilder({
    this.title = '',
    this.amount = 0,
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.w),
        borderSide: BorderSide.none,
      ),
      shadowColor: Colors.black26,
      child: SizedBox(
        width: context.width * .45,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 8.w,
                ),
                child: Text(
                  title,
                  style: context.bodyText1.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 7.h,
                  horizontal: 8.w,
                ),
                child: Text(
                  '${amount.format} đ',
                  style: style ?? context.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
