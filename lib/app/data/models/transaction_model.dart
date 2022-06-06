import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/db_keys.dart';
import '../../core/constants/enum.dart';
import '../../core/styles/style.dart';

class TransactionModel {
  final String uid;
  final String title;
  final String? description;
  final int balance;
  final TransactionType transactionType;
  final DateTime createdAt;

  TransactionModel({
    required this.uid,
    required this.title,
    required this.balance,
    required this.transactionType,
    required this.createdAt,
    this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        uid: json[DbKeys.uid],
        title: json[DbKeys.title],
        balance: json[DbKeys.balance],
        description: json[DbKeys.description],
        transactionType:
            TransactionExt.create(json[DbKeys.transactionType] as String),
        createdAt: (json[DbKeys.createdAt] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        DbKeys.uid: uid,
        DbKeys.title: title,
        DbKeys.description: description,
        DbKeys.balance: balance,
        DbKeys.transactionType: transactionType.name,
        DbKeys.createdAt: Timestamp.fromDate(createdAt),
      };

  String get formatDate => createdAt.displayDate;
  String get month => createdAt.month.toString();
  String get displayBalance => balance.format;
}
