import 'package:flutter/cupertino.dart';

import '../../core/styles/style.dart';
import 'avatar_custom.dart';
import 'icon_button_custom.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({
    Key? key,
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.onBack,
    this.actions = const [],
    this.elevation = 1,
    this.background,
    this.textColor = Colors.grey,
  }) : super(key: key);
  final String? title;
  final Widget? leading;
  final bool automaticallyImplyLeading, centerTitle;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final double elevation;
  final Color? background;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: background ?? Colors.white,
      child: SizedBox(
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {},
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const AvatarCustom(
                      imageUrl:
                          'https://images.unsplash.com/photo-1651096658061-1e32908cadbb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=800&q=60',
                      radius: 24,
                    ),
                    Dimensions.width10,
                    _TextChevronBuilder(
                      title ?? 'd',
                      color: textColor,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButtonCustom(
                    icon: CupertinoIcons.money_euro_circle,
                    size: 30,
                    onPressed: () {},
                  ),
                  IconButtonCustom(
                    icon: Icons.notifications_none,
                    size: 30,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class _TextChevronBuilder extends StatelessWidget {
  final String title;
  final Color? color;
  const _TextChevronBuilder(
    this.title, {
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        title.text.size(12).color(color!).make(),
        Icon(
          Icons.chevron_right_rounded,
          size: 18,
          color: color,
        ),
      ],
    );
  }
}
