import '../../core/constants/constants.dart';
import 'category_model.dart';

class ClassifyModel {
  final String uid;
  final CategoryModel category;
  final int defaultAmount;
  final int currentAmount;

  ClassifyModel({
    required this.uid,
    required this.category,
    this.defaultAmount = 0,
    this.currentAmount = 0,
  });

  factory ClassifyModel.fromJson(Map<String, dynamic> json) => ClassifyModel(
        uid: json[DbKeys.uid],
        category: CategoryModel.fromJson(json[DbKeys.category]),
        defaultAmount: json[DbKeys.defaultAmount],
        currentAmount: json[DbKeys.currentAmount],
      );

  Map<String, dynamic> toJson() => {
        DbKeys.uid: uid,
        DbKeys.category: category.toJson(),
        DbKeys.defaultAmount: defaultAmount,
        DbKeys.currentAmount: currentAmount,
      };

  String get title => category.title;
}

final listClassify = <ClassifyModel>[
  ClassifyModel(
    uid: 'classify1',
    category: const CategoryModel(
      uid: 'wz9zGoWX2shGMm78xnWz',
      title: 'Ăn uống',
      categoryType: CategoryType.payment,
    ),
    defaultAmount: 2000000,
    currentAmount: 1800000,
  ),
  ClassifyModel(
    uid: 'classify2',
    category: const CategoryModel(
      uid: 'Rkr8bLOxVkQAC0hmCRzr',
      title: 'Mua sắm',
      categoryType: CategoryType.payment,
    ),
    defaultAmount: 750000,
    currentAmount: 1200000,
  ),
];
