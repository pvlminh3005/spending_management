// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTransactionModel _$ListTransactionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['id_user', 'transaction_type', 'list_transactions']);
  return ListTransactionModel(
    uid: json['uid'] as String,
    idUser: json['id_user'] as String,
    transactionType:
        _$enumDecode(_$TransactionTypeEnumMap, json['transaction_type']),
    listTransactions: (json['list_transactions'] as List<dynamic>)
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListTransactionModelToJson(
        ListTransactionModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'id_user': instance.idUser,
      'transaction_type': _$TransactionTypeEnumMap[instance.transactionType],
      'list_transactions': instance.listTransactions,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TransactionTypeEnumMap = {
  TransactionType.payment: 'payment',
  TransactionType.charge: 'charge',
};
