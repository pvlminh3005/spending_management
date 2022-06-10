import '../models/category_model.dart';
import '../providers/providers.dart';

abstract class CategoryRepositoryBase {
  Future<List<CategoryModel>> getCategories();
}

class CategoryRepository implements CategoryRepositoryBase {
  @override
  Future<List<CategoryModel>> getCategories() {
    return CategoryProvider.getCategories();
  }
}
