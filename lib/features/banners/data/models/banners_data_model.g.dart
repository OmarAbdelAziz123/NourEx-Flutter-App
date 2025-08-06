// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannersDataModel _$BannersDataModelFromJson(Map<String, dynamic> json) =>
    BannersDataModel(
      message: json['message'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannersDataModelToJson(BannersDataModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'pagination': instance.pagination,
      'banners': instance.banners,
    };

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'] as String?,
      product: json['product'] == null
          ? null
          : ProductInfo.fromJson(json['product'] as Map<String, dynamic>),
      startDate: json['startDate'] as String?,
      expireDate: json['expireDate'] as String?,
      image: json['image'] as String?,
      customId: json['customId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product': instance.product,
      'startDate': instance.startDate,
      'expireDate': instance.expireDate,
      'image': instance.image,
      'customId': instance.customId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
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
