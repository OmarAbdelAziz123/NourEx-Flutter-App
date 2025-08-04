// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletDataModel _$WalletDataModelFromJson(Map<String, dynamic> json) =>
    WalletDataModel(
      status: json['status'] as String?,
      balance: (json['balance'] as num?)?.toDouble(),
      points: (json['points'] as num?)?.toInt(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => WalletTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WalletDataModelToJson(WalletDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'balance': instance.balance,
      'points': instance.points,
      'transactions': instance.transactions,
    };

WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    WalletTransaction(
      type: json['type'] as String?,
      points: (json['points'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      orderId: json['orderId'] as String?,
      description: json['description'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$WalletTransactionToJson(WalletTransaction instance) =>
    <String, dynamic>{
      'type': instance.type,
      'points': instance.points,
      'amount': instance.amount,
      'orderId': instance.orderId,
      'description': instance.description,
      '_id': instance.id,
      'createdAt': instance.createdAt,
    };
