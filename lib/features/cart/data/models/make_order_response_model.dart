import 'package:json_annotation/json_annotation.dart';

part 'make_order_response_model.g.dart';

@JsonSerializable()
class MakeOrderResponseModel {
  final String? status;
  final String? message;
  final Order? order;

  MakeOrderResponseModel({
    this.status,
    this.message,
    this.order,
  });

  factory MakeOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MakeOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOrderResponseModelToJson(this);
}

@JsonSerializable()
class Order {
  final String? userId;
  final String? address;
  final List<OrderProduct>? products;
  final dynamic coupon;
  final int? finalPrice;
  final String? status;
  final String? paymentType;
  final String? orderSeq;
  final bool? isDeleted;
  final String? id;
  final String? createdAt;
  final String? updatedAt;

  Order({
    this.userId,
    this.address,
    this.products,
    this.coupon,
    this.finalPrice,
    this.status,
    this.paymentType,
    this.orderSeq,
    this.isDeleted,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderProduct {
  final String? productId;
  final String? variantSku;
  final int? quantity;
  final int? price;
  final int? productTotal;
  final int? finalProductTotal;
  final String? id;

  OrderProduct({
    this.productId,
    this.variantSku,
    this.quantity,
    this.price,
    this.productTotal,
    this.finalProductTotal,
    this.id,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderProductFromJson(json);
  Map<String, dynamic> toJson() => _$OrderProductToJson(this);
}
