// import 'package:json_annotation/json_annotation.dart';

import 'package:json_annotation/json_annotation.dart';
import '../../../core/constants/constants.dart';
import '../../../core/styles/style.dart';

part 'transaction.g.dart';

@JsonSerializable()
class TransactionModel {
  final String uid;
  final String title;
  final String? description;
  final int balance;
  @JsonKey(required: true, name: 'expense_type')
  final TransactionType transactionType;
  @JsonKey(required: true, name: 'created_at')
  final DateTime createdAt;

  TransactionModel({
    required this.uid,
    required this.title,
    required this.transactionType,
    required this.balance,
    required this.createdAt,
    this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);

  String get formatDate => (createdAt).displayDate;
  String get month => createdAt.month.toString();
  String get displayBalance => balance.format;
  // String get convertTitle => ExpenseExt.convert(title);
}

List<TransactionModel> fakeData = [
  //? payment
  TransactionModel(
    uid: 'ex001',
    title: 'Play',
    description: 'Cafe với bae',
    balance: 45000,
    transactionType: TransactionType.payment,
    createdAt: DateTime(2022, 05, 30),
  ),
  TransactionModel(
    uid: 'ex002',
    title: 'Eat',
    description: 'Đi chợ',
    balance: 91000,
    transactionType: TransactionType.payment,
    createdAt: DateTime(2022, 05, 29),
  ),
  TransactionModel(
    uid: 'ex001',
    title: 'Study',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 9786000,
    transactionType: TransactionType.payment,
    createdAt: DateTime(2022, 05, 28),
  ),
  //? charge
  TransactionModel(
    uid: 'ex003',
    title: 'Award',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 145000,
    transactionType: TransactionType.charge,
    createdAt: DateTime.now(),
  ),
  TransactionModel(
    uid: 'ex004',
    title: 'Salary',
    description:
        'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Molestiae sapiente saepe ullam eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 145000,
    transactionType: TransactionType.charge,
    createdAt: DateTime.now(),
  ),
];
