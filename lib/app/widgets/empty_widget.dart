import '../core/styles/style.dart';
import '../core/utilities/utilities.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  const EmptyWidget({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageUtils.emptyBox),
          const SizedBox(height: 10),
          Text(
            title ?? StringUtils.emptyTransaction,
            style: context.bodyText2.copyWith(color: const Color(0xFF9A9A9A)),
          ),
        ],
      ),
    );
  }
}
