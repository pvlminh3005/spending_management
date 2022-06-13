import '../core/styles/style.dart';
import '../data/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel model;
  final int index;
  final Color? tagColor;
  final Function(TransactionModel)? onPressed;
  final Function(String)? onLongPress;

  const TransactionItem({
    required this.model,
    this.index = 0,
    this.tagColor,
    this.onPressed,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      highlightElevation: 0,
      padding: EdgeInsets.zero,
      color: index % 2 == 0 ? null : context.tertiary.withOpacity(.6),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 11.h,
          horizontal: 7.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CostTag(
              title: model.title,
              color: tagColor ?? context.primary,
            ),
            SizedBox(height: 5.h),
            if (model.description != null)
              Text(
                model.description!,
                style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.5,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                      '${model.displayBalance} đ',
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
      onPressed: () => onPressed?.call(model),
      onLongPress: () => onLongPress?.call(model.uid!),
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
