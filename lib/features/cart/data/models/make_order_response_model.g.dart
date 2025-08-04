// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderResponseModel _$MakeOrderResponseModelFromJson(
        Map<String, dynamic> json) =>
    MakeOrderResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      order: json['order'] == null
          ? null
          : Order.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MakeOrderResponseModelToJson(
        MakeOrderResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'order': instance.order,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      userId: json['userId'] as String?,
      address: json['address'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      coupon: json['coupon'],
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      status: json['status'] as String?,
      paymentType: json['paymentType'] as String?,
      orderSeq: json['orderSeq'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      id: json['id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'userId': instance.userId,
      'address': instance.address,
      'products': instance.products,
      'coupon': instance.coupon,
      'finalPrice': instance.finalPrice,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'orderSeq': instance.orderSeq,
      'isDeleted': instance.isDeleted,
      'id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

OrderProduct _$OrderProductFromJson(Map<String, dynamic> json) => OrderProduct(
      productId: json['productId'] as String?,
      variantSku: json['variantSku'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      productTotal: (json['productTotal'] as num?)?.toInt(),
      finalProductTotal: (json['finalProductTotal'] as num?)?.toInt(),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OrderProductToJson(OrderProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'variantSku': instance.variantSku,
      'quantity': instance.quantity,
      'price': instance.price,
      'productTotal': instance.productTotal,
      'finalProductTotal': instance.finalProductTotal,
      'id': instance.id,
    };
