import '../core/styles/style.dart';

enum IconTitleType {
  vertical,
  horizontal,
}

class IconTitle extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final IconData? iconData;
  final double? iconSize, width, height, space;
  final Color? color;
  final bool reverse;
  final IconTitleType type;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final VoidCallback? onPressed;

  const IconTitle({
    this.title = '',
    this.textStyle,
    this.iconData,
    this.color,
    this.iconSize,
    this.reverse = false,
    this.width = 55.0,
    this.height,
    this.space,
    this.type = IconTitleType.vertical,
    this.padding,
    this.decoration,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      color: color ?? Colors.grey.shade600,
      size: iconSize,
    );
    final style = (textStyle ?? context.caption).copyWith(color: color);
    return MaterialButton(
      onPressed: onPressed,
      minWidth: width,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(3.0),
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: decoration ??
              const BoxDecoration(
                color: Colors.transparent,
              ),
          child: ListView(
            padding: padding,
            reverse: reverse,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: type == IconTitleType.vertical
                ? Axis.vertical
                : Axis.horizontal,
            children: [
              icon,
              Dimensions.height5,
              Text(
                title,
                style: style,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
