import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../widgets/common/appbar_custom.dart';
import '../controllers/classify_detail_controller.dart';

class ClassifyDetailView extends GetView<ClassifyDetailController> {
  const ClassifyDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        color: context.primary,
        showNotification: false,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 15.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tổng hợp chi tiêu danh mục của từng tháng:',
              style: context.bodyText1,
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                spacing: 5.w,
                children: List.generate(12, (index) {
                  final DateTime _now = DateTime.now();

                  final _month = _now.month - index;
                  return _ClassifyMonthItem(
                    date: DateTime(
                      _now.year,
                      _month,
                    ),
                    onPressed: controller.toggleItem,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ClassifyMonthItem extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime)? onPressed;

  const _ClassifyMonthItem({
    required this.date,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed?.call(date);
      },
      elevation: 2,
      color: context.background,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      minWidth: context.width / 4 - 5.w * 3,
      child: Text(
        '${date.month.addFirstZero}/${date.year}',
        style: context.bodyText1.copyWith(
          fontSize: 14.sp,
          color: context.onBackground.withOpacity(.7),
        ),
      ),
    );
  }
}
