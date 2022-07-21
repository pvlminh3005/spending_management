import '../../core/constants/constants.dart';
import 'category_model.dart';

class ClassifyModel {
  final String? uid;
  final CategoryModel category;
  final int defaultBalance;
  final int currentBalance;

  ClassifyModel({
    this.uid,
    required this.category,
    this.defaultBalance = 0,
    this.currentBalance = 0,
  });

  factory ClassifyModel.fromJson(Map<String, dynamic> json) => ClassifyModel(
        uid: json[DbKeys.uid],
        category: CategoryModel.fromJson(json[DbKeys.category]),
        defaultBalance: json[DbKeys.defaultBalance],
        currentBalance: json[DbKeys.currentBalance],
      );

  Map<String, dynamic> toJson() => {
        DbKeys.uid: uid,
        DbKeys.category: category.toJson(),
        DbKeys.defaultBalance: defaultBalance,
        DbKeys.currentBalance: currentBalance,
      };

  ClassifyModel copyWith({
    String? uid,
    CategoryModel? category,
    int? defaultBalance,
    int? currentBalance,
  }) {
    return ClassifyModel(
      uid: uid ?? this.uid,
      category: category ?? this.category,
      defaultBalance: defaultBalance ?? this.defaultBalance,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }

  String get title => category.title;
  CategoryType get type => category.categoryType;
  bool get isChargeType => category.categoryType == CategoryType.charge;
}
