// import 'package:json_annotation/json_annotation.dart';

import 'package:json_annotation/json_annotation.dart';
import '../../../core/constants/constants.dart';
import '../../../core/styles/style.dart';

part 'expense.g.dart';

@JsonSerializable()
class ExpenseModel {
  final String uid;
  final String title;
  final String? description;
  final int balance;
  @JsonKey(required: true, name: 'expense_type')
  final ExpenseType expenseType;
  @JsonKey(required: true, name: 'created_at')
  final DateTime createdAt;

  ExpenseModel({
    required this.uid,
    required this.title,
    required this.expenseType,
    required this.balance,
    required this.createdAt,
    this.description,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);

  String get formatDate => (createdAt).displayDate;
  String get month => createdAt.month.toString();
  String get displayBalance => balance.format;
  // String get convertTitle => ExpenseExt.convert(title);
}

List<ExpenseModel> fakeData = [
  //? payment
  ExpenseModel(
    uid: 'ex001',
    title: 'Play',
    description: 'Cafe với bae',
    balance: 45000,
    expenseType: ExpenseType.payment,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex002',
    title: 'Eat',
    description: 'Đi chợ',
    balance: 91000,
    expenseType: ExpenseType.payment,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex001',
    title: 'Study',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 9786000,
    expenseType: ExpenseType.payment,
    createdAt: DateTime.now(),
  ),
  //? charge
  ExpenseModel(
    uid: 'ex003',
    title: 'Award',
    description:
        'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 145000,
    expenseType: ExpenseType.charge,
    createdAt: DateTime.now(),
  ),
  ExpenseModel(
    uid: 'ex004',
    title: 'Salary',
    description:
        'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Molestiae sapiente saepe ullam eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
    balance: 145000,
    expenseType: ExpenseType.charge,
    createdAt: DateTime.now(),
  ),
];
