// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDataModel _$CartDataModelFromJson(Map<String, dynamic> json) =>
    CartDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : CartResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartDataModelToJson(CartDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };

CartResult _$CartResultFromJson(Map<String, dynamic> json) => CartResult(
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartResultToJson(CartResult instance) =>
    <String, dynamic>{
      'products': instance.products,
      'totalPrice': instance.totalPrice,
    };

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
      id: json['_id'] as String?,
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      finalPrice: (json['finalPrice'] as num?)?.toInt(),
      variantSku: json['variantSku'] as String?,
      variantAttributes: (json['variantAttributes'] as List<dynamic>?)
          ?.map((e) => VariantAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      itemTotal: (json['itemTotal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'mainImageURL': instance.mainImageURL,
      'quantity': instance.quantity,
      'finalPrice': instance.finalPrice,
      'variantSku': instance.variantSku,
      'variantAttributes': instance.variantAttributes,
      'itemTotal': instance.itemTotal,
    };

VariantAttribute _$VariantAttributeFromJson(Map<String, dynamic> json) =>
    VariantAttribute(
      name: json['name'] as String?,
      value: json['value'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$VariantAttributeToJson(VariantAttribute instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      '_id': instance.id,
    };
