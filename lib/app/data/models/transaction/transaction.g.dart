// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['expense_type', 'created_at']);
  return TransactionModel(
    uid: json['uid'] as String,
    title: json['title'] as String,
    transactionType: _$enumDecode(_$ExpenseTypeEnumMap, json['expense_type']),
    balance: json['balance'] as int,
    createdAt: DateTime.parse(json['created_at'] as String),
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'balance': instance.balance,
      'expense_type': _$ExpenseTypeEnumMap[instance.transactionType],
      'created_at': instance.createdAt.toIso8601String(),
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

const _$ExpenseTypeEnumMap = {
  TransactionType.payment: 'payment',
  TransactionType.charge: 'charge',
};
