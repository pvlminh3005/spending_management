import '../core/styles/style.dart';
import '../data/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel model;
  final int index;
  final Color? tagColor;
  final Function(TransactionModel)? onPressed;
  final Function(TransactionModel)? onLongPress;

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
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 7,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CostTag(
              title: model.title,
              color: tagColor ?? context.primary,
            ),
            const SizedBox(height: 5),
            if (model.description.isNotBlank)
              Text(
                model.description,
                style: context.bodyText1.copyWith(
                  fontSize: 14.sp,
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
                  style: context.caption.copyWith(fontSize: 12.sp),
                  maxLines: 1,
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${model.displayBalance} đ',
                      style: context.subtitle2.copyWith(
                        fontSize: 16.sp,
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
      onLongPress: () => onLongPress?.call(model),
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
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        child: Text(
          title,
          style: context.caption.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
