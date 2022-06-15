import '../../core/constants/db_keys.dart';
import '../../core/constants/enum.dart';
import '../../core/extensions/enum_extension.dart';

class CategoryModel {
  final String? uid;
  final String title;
  final CategoryType categoryType;

  const CategoryModel({
    this.uid,
    required this.title,
    required this.categoryType,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        uid: json[DbKeys.uid],
        title: json[DbKeys.title],
        categoryType: CategoryExt.create(json[DbKeys.categoryType] as String),
      );

  Map<String, dynamic> toJson() => {
        DbKeys.uid: uid,
        DbKeys.title: title,
        DbKeys.categoryType: convertType(categoryType),
      };

  CategoryModel copyWith({
    String? uid,
    String? title,
    CategoryType? categoryType,
  }) {
    return CategoryModel(
      uid: uid ?? this.uid,
      title: title ?? this.title,
      categoryType: categoryType ?? this.categoryType,
    );
  }

  static String convertType(CategoryType type) => type.name;

  @override
  String toString() {
    return 'UID: $uid + title: $title + type: $categoryType';
  }
}
