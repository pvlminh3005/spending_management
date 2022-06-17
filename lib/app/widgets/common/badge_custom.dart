import '../../core/styles/style.dart';

class BadgeCustom extends StatelessWidget {
  final Widget child;
  final int count;
  final bool isCount;
  final Color? color;

  const BadgeCustom({
    required this.child,
    this.count = 0,
    this.isCount = true,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (count != 0 && !isCount)
          Positioned(
            top: 7,
            right: 7,
            child: CircleAvatar(
              backgroundColor: color ?? theme.primaryColor,
              radius: 8,
              child: Text(
                count > 99 ? '+99' : '$count',
                style: context.bodyText1.copyWith(
                  fontSize: 7.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        else
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              radius: 5.sp,
              backgroundColor: color ?? theme.primaryColor,
            ),
          ),
      ],
    );
  }
}
