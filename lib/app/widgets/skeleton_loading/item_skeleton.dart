import '../../core/styles/style.dart';
import '../common/shimmer.dart';

class ItemSkeleton extends StatelessWidget {
  const ItemSkeleton({
    Key? key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  final double? width, height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey.shade100,
      baseColor: Colors.grey.shade300,
      child: child ??
          ColoredBox(
            color: context.dividerColor,
            child: SizedBox.fromSize(
              size: Size(width ?? 0, height ?? 0),
              child: child,
            ),
          ),
    );
  }
}

class ItemLoading extends StatelessWidget {
  const ItemLoading({
    Key? key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.radius = 0,
  }) : super(key: key);
  final double width, height, radius;
  @override
  Widget build(BuildContext context) {
    return ItemSkeleton(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.dividerColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}
