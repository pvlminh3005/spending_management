import '../core/styles/style.dart';

class StatisticCard extends StatelessWidget {
  final Widget? child;

  const StatisticCard({
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 2,
              color: Colors.black12,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const _HeaderCardItem(
                    title: 'Tổng tiền chi',
                    total: 150000,
                  ),
                  _HeaderCardItem(
                    title: 'Tổng tiền thu',
                    total: 3500000,
                    color: context.secondary,
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCardItem extends StatelessWidget {
  final String title;
  final double total;
  final Color color;
  const _HeaderCardItem({
    this.title = '',
    this.total = 0,
    this.color = Colors.orange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text(
              title,
              style: context.bodyText1.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            Dimensions.height5,
            FittedBox(
              child: Text(
                '${total.format} đ',
                style: context.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
