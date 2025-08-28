// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersDataModel _$MyOrdersDataModelFromJson(Map<String, dynamic> json) =>
    MyOrdersDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => MyOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOrdersDataModelToJson(MyOrdersDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pagination': instance.pagination,
      'result': instance.result,
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

MyOrder _$MyOrderFromJson(Map<String, dynamic> json) => MyOrder(
      id: json['_id'] as String?,
      orderSeq: json['orderSeq'] as String?,
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
      paymentType: json['paymentType'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => MyOrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] == null
          ? null
          : MyOrderAddress.fromJson(json['address'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : MyOrderUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyOrderToJson(MyOrder instance) => <String, dynamic>{
      '_id': instance.id,
      'orderSeq': instance.orderSeq,
      'createdAt': instance.createdAt,
      'status': instance.status,
      'paymentType': instance.paymentType,
      'products': instance.products,
      'address': instance.address,
      'user': instance.user,
    };

MyOrderProduct _$MyOrderProductFromJson(Map<String, dynamic> json) =>
    MyOrderProduct(
      description: json['description'] as String?,
      averageRating: (json['averageRating'] as num?)?.toInt(),
      totalOrderCount: (json['totalOrderCount'] as num?)?.toInt(),
      productId: json['productId'] as String?,
      finalProductTotal: (json['finalProductTotal'] as num?)?.toDouble(),
      status: json['status'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
      name: json['name'] as String?,
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => MyOrderVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyOrderProductToJson(MyOrderProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'finalProductTotal': instance.finalProductTotal,
      'status': instance.status,
      'mainImageURL': instance.mainImageURL,
      'description': instance.description,
      'averageRating': instance.averageRating,
      'totalOrderCount': instance.totalOrderCount,
      'name': instance.name,
      'variants': instance.variants,
    };

MyOrderVariant _$MyOrderVariantFromJson(Map<String, dynamic> json) =>
    MyOrderVariant(
      skuId: (json['skuId'] as num?)?.toInt(),
      itemSeq: json['itemSeq'] as String?,
      sku: json['sku'] as String?,
      stockAmount: (json['stockAmount'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toDouble(),
      discountRounded: (json['discountRounded'] as num?)?.toInt(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => MyOrderAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$MyOrderVariantToJson(MyOrderVariant instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'itemSeq': instance.itemSeq,
      'sku': instance.sku,
      'stockAmount': instance.stockAmount,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'discountRounded': instance.discountRounded,
      'attributes': instance.attributes,
      '_id': instance.id,
    };

MyOrderAttribute _$MyOrderAttributeFromJson(Map<String, dynamic> json) =>
    MyOrderAttribute(
      name: json['name'] as String?,
      value: json['value'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$MyOrderAttributeToJson(MyOrderAttribute instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      '_id': instance.id,
    };

MyOrderUser _$MyOrderUserFromJson(Map<String, dynamic> json) => MyOrderUser(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$MyOrderUserToJson(MyOrderUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };

MyOrderAddress _$MyOrderAddressFromJson(Map<String, dynamic> json) =>
    MyOrderAddress(
      city: json['city'] as String?,
      zone: json['zone'] as String?,
      street: json['street'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$MyOrderAddressToJson(MyOrderAddress instance) =>
    <String, dynamic>{
      'city': instance.city,
      'zone': instance.zone,
      'street': instance.street,
      'notes': instance.notes,
    };
