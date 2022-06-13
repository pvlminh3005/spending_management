import 'package:get/get.dart' hide ContextExtensionss;

import '../../../core/styles/style.dart';
import '../../../data/models/classify_model.dart';
import '../controllers/classify_controller.dart';

class ClassifyView extends GetView<ClassifyController> {
  const ClassifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _FrameBuilder(
              frameOne: _HeaderTitle(
                'Phân loại',
                style: TextStyle(fontSize: 15.sp),
              ),
              frameTwo: _HeaderTitle(
                'Dự tính',
                style: TextStyle(fontSize: 15.sp),
              ),
              frameThree: _HeaderTitle(
                'Thực tế',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listClassify.length,
              itemBuilder: (BuildContext context, int index) {
                final model = listClassify[index];
                return _ClassifyItem(
                  model: model,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassifyItem extends StatelessWidget {
  final ClassifyModel model;
  final VoidCallback? onTap;

  const _ClassifyItem({
    required this.model,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Color color = model.defaultAmount - model.currentAmount
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: _FrameBuilder(
          frameOne: _HeaderTitle(
            model.title,
          ),
          frameTwo: _HeaderTitle(
            model.defaultAmount.format,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
          frameThree: _HeaderTitle(
            model.currentAmount.format,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class _FrameBuilder extends StatelessWidget {
  final Widget frameOne;
  final Widget frameTwo;
  final Widget frameThree;

  const _FrameBuilder({
    Key? key,
    required this.frameOne,
    required this.frameTwo,
    required this.frameThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: frameOne,
        ),
        Expanded(
          flex: 3,
          child: frameTwo,
        ),
        Expanded(
          flex: 3,
          child: frameThree,
        ),
      ],
    );
  }
}

class _HeaderTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;

  const _HeaderTitle(
    this.title, {
    this.style,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.bodyText1.copyWith(
        fontSize: style?.fontSize,
        color: style?.color,
        fontWeight: style?.fontWeight,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
