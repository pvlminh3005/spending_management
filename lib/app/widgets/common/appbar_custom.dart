import 'package:flutter/cupertino.dart';

import '../../core/styles/style.dart';
import 'badge_custom.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final bool showNotification;

  const AppBarCustom({
    this.title = '',
    this.style,
    this.backgroundColor,
    this.showNotification = true,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      leading: BackButton(
        onPressed: onPressed,
        color: style?.color ?? context.onBackground,
      ),
      title: Text(
        title,
        style: context.bodyText1.copyWith(
          fontSize: style?.fontSize?.sp ?? 20.sp,
          color: style?.color,
          fontWeight: style?.fontWeight,
        ),
      ),
      actions: [
        if (showNotification)
          BadgeCustom(
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bell_solid,
                size: 25.sp,
                color: theme.textTheme.bodyText1?.color,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
