// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['created_at']);
  return TransactionModel(
    uid: json['uid'] as String,
    title: json['title'] as String,
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
      'created_at': instance.createdAt.toIso8601String(),
    };
