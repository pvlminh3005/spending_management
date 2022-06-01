import '../core/styles/style.dart';
import '../core/utilities/utilities.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageUtils.emptyBox),
        const SizedBox(height: 15),
        Text(
          StringUtils.emptyTransaction,
          style: context.subtitle1.copyWith(color: const Color(0xFF9A9A9A)),
        ),
      ],
    );
  }
}
