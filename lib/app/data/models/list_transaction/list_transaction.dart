import 'package:json_annotation/json_annotation.dart';

import '../../../core/constants/enum.dart';
import '../transaction/transaction.dart';

part 'list_transaction.g.dart';

@JsonSerializable()
class ListTransactionModel {
  ListTransactionModel({
    required this.uid,
    required this.idUser,
    required this.transactionType,
    this.listTransactions = const [],
  });

  final String uid;
  @JsonKey(required: true, name: 'id_user')
  final String idUser;
  @JsonKey(required: true, name: 'transaction_type')
  final TransactionType transactionType;
  @JsonKey(required: true, name: 'list_transactions')
  final List<TransactionModel> listTransactions;

  factory ListTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$ListTransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListTransactionModelToJson(this);
}

final paymentTransaction = ListTransactionModel(
  uid: 'paymentTransaction',
  idUser: 'user1234',
  transactionType: TransactionType.payment,
  listTransactions: [
    TransactionModel(
      uid: 'ex001',
      title: 'Play',
      description: 'Cafe với bae',
      balance: 45000,
      createdAt: DateTime(2022, 05, 30),
    ),
    TransactionModel(
      uid: 'ex002',
      title: 'Eat',
      description: 'Đi chợ',
      balance: 91000,
      createdAt: DateTime(2022, 05, 29),
    ),
    TransactionModel(
      uid: 'ex001',
      title: 'Study',
      description:
          'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
      balance: 9786000,
      createdAt: DateTime(2022, 05, 28),
    ),
  ],
);

final chargeTransactions = ListTransactionModel(
  uid: 'chargeTransaction',
  idUser: 'user1234',
  transactionType: TransactionType.charge,
  listTransactions: [
    TransactionModel(
      uid: 'ex003',
      title: 'Award',
      description:
          'Eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
      balance: 145000,
      createdAt: DateTime.now(),
    ),
    TransactionModel(
      uid: 'ex004',
      title: 'Salary',
      description:
          'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Molestiae sapiente saepe ullam eveniet cum assumenda ab laborum ut consectetur quia, qui accusamus ratione vitae debitis voluptatum ad similique, laboriosam tenetur?',
      balance: 145000,
      createdAt: DateTime.now(),
    ),
  ],
);
