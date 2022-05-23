import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'badge_custom.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final List<Widget>? actions;

  const AppBarCustom({
    this.title = '',
    this.onPressed,
    this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      elevation: 0,
      backgroundColor: theme.backgroundColor,
      leading: BackButton(
        onPressed: onPressed,
        color: theme.textTheme.bodyText1?.color,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyText1?.copyWith(fontSize: 18),
      ),
      actions: [
        BadgeCustom(
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.bell_solid,
              size: 26,
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
