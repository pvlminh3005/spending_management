import '../../core/constants/enum.dart';
import '../models/category_model.dart';
import '../providers/providers.dart';

abstract class CategoryRepositoryBase {
  Future<List<CategoryModel>> getCategories({required CategoryType type});
  Future<void> createCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory({
    required CategoryType type,
    required String uidCategory,
  });
}

class CategoryRepository implements CategoryRepositoryBase {
  @override
  Future<List<CategoryModel>> getCategories({required CategoryType type}) {
    return CategoryProvider.getCategories(type: type);
  }

  @override
  Future<void> createCategory(CategoryModel category) {
    return CategoryProvider.createCategory(category);
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    return CategoryProvider.updateCategory(category);
  }

  @override
  Future<void> deleteCategory({
    required CategoryType type,
    required String uidCategory,
  }) {
    return CategoryProvider.deleteCategory(
      type: type,
      uidCategory: uidCategory,
    );
  }
}
