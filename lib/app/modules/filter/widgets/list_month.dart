import '../../../core/styles/style.dart';
import '../../../core/utilities/utilities.dart';

class ListMonthWidget extends StatelessWidget {
  final int currentMonth;
  final Function(int)? onSelected;

  const ListMonthWidget({
    required this.currentMonth,
    this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringUtils.filterByMonth,
          style: context.bodyText1.copyWith(fontSize: 14.sp),
        ),
        const SizedBox(height: 10),
        Center(
          child: Wrap(
            runSpacing: 10.h,
            spacing: 5.w,
            children: List.generate(12, (index) {
              final month = index + 1;
              return _TextMonthItem(
                '${StringUtils.month} $month',
                index: index,
                isActive: currentMonth == index,
                onPressed: onSelected,
              );
            }).toList(),
          ),
        ),
      ],
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
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey.shade300,
            blurRadius: 3,
          ),
        ],
        color: isActive ? context.primary : context.background,
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => onPressed?.call(index),
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: width ?? context.width / 4 - 3.w * 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                title,
                style: context.caption.copyWith(
                  fontSize: 12.sp,
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
