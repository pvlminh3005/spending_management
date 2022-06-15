import '../../core/styles/style.dart';
import '../../data/models/category_model.dart';

class ListCategoryWidget extends StatelessWidget {
  final List<CategoryModel> listCategories;
  final CategoryModel currentCategory;
  final Function(CategoryModel)? onSelected;

  const ListCategoryWidget({
    required this.listCategories,
    required this.currentCategory,
    this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentCategoryUid = ValueNotifier<String>(currentCategory.uid!);
    return ValueListenableBuilder(
      valueListenable: _currentCategoryUid,
      builder: (BuildContext ctx, String value, Widget? _) {
        return Wrap(
          spacing: 7,
          runSpacing: 7,
          children: List.generate(
            listCategories.length,
            (index) {
              final CategoryModel model = listCategories[index];
              return _CustomItemType(
                category: model,
                uid: value,
                onPressed: (newUid) {
                  _currentCategoryUid.value = newUid;
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

  const _CustomItemType({
    required this.category,
    required this.uid,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: uid == category.uid ? context.primary : context.background,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.black12,
            blurRadius: 2,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
      duration: const Duration(milliseconds: 100),
      child: InkWell(
        onTap: () => onPressed?.call(category.uid!),
        borderRadius: BorderRadius.circular(6.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Text(
            category.title,
            style: context.caption.copyWith(
              color: uid == category.uid ? Colors.white : context.caption.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
