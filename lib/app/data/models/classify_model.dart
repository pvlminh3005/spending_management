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
}

final listClassify = <ClassifyModel>[
  ClassifyModel(
    uid: 'classify1',
    category: const CategoryModel(
      uid: 'wz9zGoWX2shGMm78xnWz',
      title: 'Ăn uống',
      categoryType: CategoryType.payment,
    ),
    defaultBalance: 2000000,
    currentBalance: 1800000,
  ),
  ClassifyModel(
    uid: 'classify2',
    category: const CategoryModel(
      uid: 'Rkr8bLOxVkQAC0hmCRzr',
      title: 'Mua sắm',
      categoryType: CategoryType.payment,
    ),
    defaultBalance: 750000,
    currentBalance: 1200000,
  ),
  ClassifyModel(
    uid: 'classify3',
    category: const CategoryModel(
      uid: '3Z31zrR81mUntrCojlF5',
      title: 'Lương',
      categoryType: CategoryType.charge,
    ),
    currentBalance: 12000000,
  ),
];
