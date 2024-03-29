import '../../core/styles/style.dart';
import '../../data/models/category_model.dart';

class ListCategoryWidget extends StatelessWidget {
  final List<CategoryModel> listCategories;
  final CategoryModel? currentCategory;
  final void Function(CategoryModel)? onSelected;
  final bool isTapToDisable;
  final Color? selectedColor;

  const ListCategoryWidget({
    required this.listCategories,
    required this.currentCategory,
    this.onSelected,
    this.isTapToDisable = false,
    this.selectedColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentCategoryUid = ValueNotifier<String?>(currentCategory?.uid);
    return ValueListenableBuilder(
      valueListenable: _currentCategoryUid,
      builder: (BuildContext ctx, String? value, Widget? _) {
        return Wrap(
          spacing: 7,
          runSpacing: 6,
          children: List.generate(
            listCategories.length,
            (index) {
              final CategoryModel model = listCategories[index];
              return _CustomItemType(
                category: model,
                uid: value ?? '',
                selectedColor: selectedColor ?? context.primary,
                onPressed: (newUid) {
                  _currentCategoryUid.value = newUid;
                  if (isTapToDisable) {
                    if (newUid == value) {
                      _currentCategoryUid.value = '';
                    }
                  }
                  onSelected?.call(model);
                },
              );
            },
          ).toList(),
        );
      },
    );
  }
}

class _CustomItemType extends StatelessWidget {
  final CategoryModel category;
  final String uid;
  final Function(String)? onPressed;
  final Color selectedColor;

  const _CustomItemType({
    required this.category,
    required this.uid,
    required this.selectedColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: uid == category.uid
            ? selectedColor
            : context.theme.brightness == Brightness.dark
                ? const Color(0xFF333333)
                : Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: context.onBackground.withOpacity(.15),
            blurRadius: 3,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
      duration: const Duration(milliseconds: 150),
      child: InkWell(
        onTap: () => onPressed?.call(category.uid!),
        borderRadius: BorderRadius.circular(6.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Text(
            category.title,
            style: context.caption.copyWith(
              fontSize: 12.sp,
              color: uid == category.uid ? Colors.white : context.caption.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
