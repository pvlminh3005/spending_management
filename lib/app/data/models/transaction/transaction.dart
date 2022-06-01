import 'package:json_annotation/json_annotation.dart';
import '../../../core/styles/style.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  final String uid;
  final String title;
  final String? description;
  final int balance;
  @JsonKey(required: true, name: 'created_at')
  final DateTime createdAt;

  TransactionModel({
    required this.uid,
    required this.title,
    required this.balance,
    required this.createdAt,
    this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  String get formatDate => createdAt.displayDate;
  String get month => createdAt.month.toString();
  String get displayBalance => balance.format;
  // String get convertTitle => ExpenseExt.convert(title);
}
