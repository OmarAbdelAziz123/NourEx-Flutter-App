// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'returned_orders_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnedOrdersDataModel _$ReturnedOrdersDataModelFromJson(
        Map<String, dynamic> json) =>
    ReturnedOrdersDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ReturnedOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReturnedOrdersDataModelToJson(
        ReturnedOrdersDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pagination': instance.pagination,
      'result': instance.result,
    };

ReturnedOrder _$ReturnedOrderFromJson(Map<String, dynamic> json) =>
    ReturnedOrder(
      id: json['_id'] as String?,
      reason: json['reason'] as String?,
      returnSeq: json['returnSeq'] as String?,
      imageURLs: (json['imageURLs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ReturnedProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      order: json['order'] == null
          ? null
          : ReturnedOrderMetaOrder.fromJson(
              json['order'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : ReturnedOrderAddress.fromJson(
              json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnedOrderToJson(ReturnedOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'reason': instance.reason,
      'returnSeq': instance.returnSeq,
      'imageURLs': instance.imageURLs,
      'createdAt': instance.createdAt,
      'products': instance.products,
      'order': instance.order,
      'address': instance.address,
    };

ReturnedProduct _$ReturnedProductFromJson(Map<String, dynamic> json) =>
    ReturnedProduct(
      productId: json['productId'] as String?,
      variantSku: json['variantSku'] as String?,
      status: json['status'] as String?,
      name: json['name'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
      vendor: json['vendor'] == null
          ? null
          : ReturnedVendor.fromJson(json['vendor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReturnedProductToJson(ReturnedProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'variantSku': instance.variantSku,
      'status': instance.status,
      'name': instance.name,
      'mainImageURL': instance.mainImageURL,
      'vendor': instance.vendor,
    };

ReturnedVendor _$ReturnedVendorFromJson(Map<String, dynamic> json) =>
    ReturnedVendor(
      id: json['_id'] as String?,
      storeName: json['storeName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ReturnedVendorToJson(ReturnedVendor instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'storeName': instance.storeName,
      'email': instance.email,
      'phone': instance.phone,
    };

ReturnedOrderMetaOrder _$ReturnedOrderMetaOrderFromJson(
        Map<String, dynamic> json) =>
    ReturnedOrderMetaOrder(
      id: json['_id'] as String?,
      orderSeq: json['orderSeq'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ReturnedOrderMetaOrderToJson(
        ReturnedOrderMetaOrder instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'orderSeq': instance.orderSeq,
      'status': instance.status,
    };

ReturnedOrderAddress _$ReturnedOrderAddressFromJson(
        Map<String, dynamic> json) =>
    ReturnedOrderAddress(
      phoneNo: (json['phoneNo'] as num?)?.toInt(),
      city: json['city'] as String?,
      zone: json['zone'] as String?,
      street: json['street'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ReturnedOrderAddressToJson(
        ReturnedOrderAddress instance) =>
    <String, dynamic>{
      'phoneNo': instance.phoneNo,
      'city': instance.city,
      'zone': instance.zone,
      'street': instance.street,
      'notes': instance.notes,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'pages': instance.pages,
    };
