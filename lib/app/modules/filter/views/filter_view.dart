import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../widgets/common/app_button.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentFilter = ValueNotifier<int?>(controller.currentMonth);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(),
        title: const Text('Bộ lọc'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: ValueListenableBuilder(
          valueListenable: _currentFilter,
          builder: ((context, int? value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const _DateTimeCustom(
                //   title: 'Từ ngày',
                // ),
                // SizedBox(height: 15.h),
                // const _DateTimeCustom(
                //   title: 'Đến ngày',
                // ),
                SizedBox(height: 20.h),
                Text(
                  'Lọc theo tháng',
                  style: context.bodyText1.copyWith(fontSize: 18.sp),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Wrap(
                    runSpacing: 5.h,
                    spacing: 5.w,
                    children: List.generate(12, (index) {
                      return _TextMonthItem(
                        'Tháng ${index + 1}',
                        index: index,
                        isActive: value == index,
                        onPressed: (index) {
                          _currentFilter.value = index;
                        },
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx(
                      () => AppButton(
                        'Áp dụng',
                        axisSize: MainAxisSize.max,
                        loading: controller.isLoading,
                        onPressed: _currentFilter.value != null
                            ? () {
                                controller.applyFilter(value);
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _TextMonthItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final double? width;
  final int index;
  final Function(int)? onPressed;
  const _TextMonthItem(
    this.title, {
    this.isActive = false,
    this.index = 0,
    this.width,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: Colors.grey.shade100,
      color: isActive ? context.primary : null,
      child: InkWell(
        onTap: () {
          onPressed?.call(index);
        },
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: width ?? context.width / 4 - 3.w * 3,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Center(
              child: Text(
                title,
                style: context.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isActive ? context.background : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _DateTimeCustom extends StatelessWidget {
//   final String title;
//   final TextEditingController? controller;
//   final Function(DateTime?)? onPressed;

//   const _DateTimeCustom({
//     required this.title,
//     this.controller,
//     this.onPressed,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final dateNow = DateTime.now();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           title,
//           style: context.caption.copyWith(
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(height: 5.h),
//         InkWell(
//           onTap: () async {
//             var data = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(dateNow.year - 1),
//               lastDate: DateTime(dateNow.year + 1),
//             );

//             onPressed?.call(data);
//           },
//           borderRadius: BorderRadius.circular(4),
//           child: InputCustom(
//             controller: controller,
//             borderSide: const BorderSide(color: Colors.grey),
//             isShowPrefixIcon: true,
//             isEnabled: false,
//             prefixIcon: Icon(
//               CupertinoIcons.calendar,
//               color: Colors.grey,
//               size: 23.w,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
