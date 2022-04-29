import '../core/styles/style.dart';

enum IconTitleType {
  vertical,
  horizontal,
}

enum PositionIconType {
  start,
  end,
}

class IconTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final IconData? iconData;
  final double? iconSize, width;
  final Color? color;
  final IconTitleType type;
  final PositionIconType positionIcon;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const IconTitle({
    this.title = '',
    this.style,
    this.iconData,
    this.color,
    this.iconSize,
    this.width,
    this.type = IconTitleType.vertical,
    this.positionIcon = PositionIconType.start,
    this.padding,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      color: color,
      size: iconSize,
    );
    final text = Text(
      title,
      style: (style ?? context.caption).copyWith(color: color),
      textAlign: TextAlign.center,
    );
    return MaterialButton(
      onPressed: onPressed,
      child: SizedBox(
        width: width,
        child: ListView(
          shrinkWrap: true,
          padding: padding,
          scrollDirection:
              type == IconTitleType.vertical ? Axis.vertical : Axis.horizontal,
          reverse: positionIcon == PositionIconType.end,
          children: [
            icon,
            if (type == IconTitleType.vertical)
              Dimensions.height5
            else
              Dimensions.width5,
            text,
          ],
        ),
      ),
    );
  }
}
