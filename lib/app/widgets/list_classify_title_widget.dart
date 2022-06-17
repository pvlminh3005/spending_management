import 'package:get/get.dart';

import '../core/styles/style.dart';
import '../data/models/category_model.dart';
import 'list_category/list_category_widget.dart';

class ListClassifyTitleWidget extends StatelessWidget {
  final List<CategoryModel> listCategories;
  final CategoryModel? currentCategory;
  final Function(CategoryModel)? onSelected;
  final bool isTapToDisable;
  final Color? selectedColor;

  const ListClassifyTitleWidget({
    required this.listCategories,
    this.currentCategory,
    this.onSelected,
    this.isTapToDisable = false,
    this.selectedColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phân loại',
          style: context.bodyText1.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        ListCategoryWidget(
          listCategories: listCategories,
          currentCategory: currentCategory,
          isTapToDisable: isTapToDisable,
          selectedColor: selectedColor,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
