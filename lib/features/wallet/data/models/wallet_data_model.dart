import 'package:json_annotation/json_annotation.dart';

part 'wallet_data_model.g.dart';

@JsonSerializable()
class WalletDataModel {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'balance')
  final double? balance;

  @JsonKey(name: 'points')
  final int? points;

  @JsonKey(name: 'transactions')
  final List<WalletTransaction>? transactions;

  WalletDataModel({
    this.status,
    this.balance,
    this.points,
    this.transactions,
  });

  factory WalletDataModel.fromJson(Map<String, dynamic> json) =>
      _$WalletDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDataModelToJson(this);
}

@JsonSerializable()
class WalletTransaction {
  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'points')
  final int? points;

  @JsonKey(name: 'amount')
  final double? amount;

  @JsonKey(name: 'orderId')
  final String? orderId;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  WalletTransaction({
    this.type,
    this.points,
    this.amount,
    this.orderId,
    this.description,
    this.id,
    this.createdAt,
  });

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$WalletTransactionToJson(this);
}
