import '../../core/constants/db_keys.dart';

class CategoryModel {
  final String uid;
  final String title;

  const CategoryModel({
    required this.uid,
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        uid: json[DbKeys.uid],
        title: json[DbKeys.title],
      );

  Map<String, dynamic> toJson() => {
        DbKeys.uid: uid,
        DbKeys.title: title,
      };
}
