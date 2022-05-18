import '../core/styles/style.dart';
import '../data/models/expense_model.dart';

class SpendingManageItem extends StatelessWidget {
  final ExpenseModel model;
  final int index;
  final Color? tagColor;

  const SpendingManageItem({
    required this.model,
    this.index = 0,
    this.tagColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.zero,
      color: index % 2 == 0 ? null : Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 11.h,
          horizontal: 7.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CostTag(
              title: model.titleTagBuilder(model.costType),
              color: tagColor ?? context.primary,
            ),
            SizedBox(height: 5.h),
            Text(
              model.description,
              style: TextStyle(
                fontSize: 13.sp,
                height: 1.5,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Row(
              children: [
                Text(
                  model.formatDate,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${model.price.format} đ',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: tagColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}

class _CostTag extends StatelessWidget {
  final String title;
  final Color? color;
  const _CostTag({
    required this.title,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.w),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 6.h,
          horizontal: 10.w,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
