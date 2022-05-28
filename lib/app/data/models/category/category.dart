import 'package:json_annotation/json_annotation.dart';

import '../../../core/extensions/extension.dart';

part 'category.g.dart';

@JsonSerializable()
class CategoryModel {
  final String uid;
  final String title;

  CategoryModel({
    required this.uid,
    required this.title,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  String get capitalizeTitle => title.toCapitalized;
}

final listCategory = <CategoryModel>[
  CategoryModel(
    uid: 'Category1',
    title: 'Ăn uống',
  ),
  CategoryModel(
    uid: 'Category2',
    title: 'Cá nhân',
  ),
  CategoryModel(
    uid: 'Category3',
    title: 'Mua sắm',
  ),
];
