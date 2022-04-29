import '../../core/styles/style.dart';

class IconButtonCustom extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;
  final Color? color;

  const IconButtonCustom({
    required this.icon,
    required this.onPressed,
    this.size = 25,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          size: size,
          color: color ?? Colors.grey.shade700,
        ),
      ),
    );
  }
}
