import '../../core/constants/constants.dart';
import '../../core/extensions/enum_extension.dart';
import 'transaction_model.dart';

class ListTransactionModel {
  ListTransactionModel({
    required this.uid,
    required this.transactionType,
    this.listTransactions = const [],
  });

  final String uid;
  final TransactionType transactionType;
  final List<TransactionModel> listTransactions;

  factory ListTransactionModel.fromJson(Map<String, dynamic> json) =>
      ListTransactionModel(
        uid: json[DbKeys.uid],
        transactionType:
            TransactionExt.create(json[DbKeys.transactionType] as String),
        listTransactions: (json[DbKeys.listTransactions] as List)
            .map((e) => TransactionModel.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        DbKeys.uid: uid,
        DbKeys.transactionType: transactionType.name,
        DbKeys.listTransactions:
            listTransactions.map((e) => e.toJson()).toList(),
      };
}

final paymentTransaction = ListTransactionModel(
  uid: 'paymentTransaction',
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
