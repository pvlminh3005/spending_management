import '../../core/constants/enum.dart';
import '../models/category_model.dart';
import '../providers/providers.dart';

abstract class CategoryRepositoryBase {
  Future<List<CategoryModel>> getCategories({required CategoryType type});
}

class CategoryRepository implements CategoryRepositoryBase {
  @override
  Future<List<CategoryModel>> getCategories({required CategoryType type}) {
    return CategoryProvider.getCategories(type: type);
  }
}
