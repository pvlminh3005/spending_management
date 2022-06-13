import '../../core/constants/db_keys.dart';
import '../../core/constants/enum.dart';
import '../../core/styles/style.dart';
import 'category_model.dart';

class TransactionModel {
  final String? uid;
  final CategoryModel category;
  final String? description;
  final int balance;
  final TransactionType transactionType;
  final DateTime createdAt;

  TransactionModel({
    this.uid,
    required this.category,
    required this.balance,
    required this.transactionType,
    required this.createdAt,
    this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        uid: json[DbKeys.uid],
        category: CategoryModel.fromJson(json[DbKeys.category]),
        balance: json[DbKeys.balance],
        description: json[DbKeys.description],
        transactionType:
            TransactionExt.create(json[DbKeys.transactionType] as String),
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(json[DbKeys.createdAt] as int),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        DbKeys.uid: uid,
        DbKeys.category: category.toJson(),
        DbKeys.description: description,
        DbKeys.balance: balance,
        DbKeys.transactionType: convertType(transactionType),
        DbKeys.createdAt: createdAt.millisecondsSinceEpoch,
      };

  //* Convert String
  String get title => category.title;
  String get formatDate => createdAt.displayDate;
  String get month => createdAt.month.toString();
  String get displayBalance => balance.format;

  //* Convert to model
  static DateTime convertDate(String date) => DateTimeExt.parseDate(date);
  static String convertType(TransactionType type) => type.name;
}
