// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDataModel _$ProductDataModelFromJson(Map<String, dynamic> json) =>
    ProductDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDataModelToJson(ProductDataModel instance) =>
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

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
      createdAt: json['createdAt'] as String?,
      createdBy: json['createdBy'] == null
          ? null
          : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'description': instance.description,
      'mainImageURL': instance.mainImageURL,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      vendorName: json['vendorName'] as String?,
      varifiedVendor: json['varifiedVendor'] as bool?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'vendorName': instance.vendorName,
      'varifiedVendor': instance.varifiedVendor,
      'profilePic': instance.profilePic,
    };
