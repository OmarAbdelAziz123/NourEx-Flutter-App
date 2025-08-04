// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDataModel _$CategoryDataModelFromJson(Map<String, dynamic> json) =>
    CategoryDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDataModelToJson(CategoryDataModel instance) =>
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

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'createdBy': instance.createdBy,
    };
