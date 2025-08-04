// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addresses_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressesDataModel _$AddressesDataModelFromJson(Map<String, dynamic> json) =>
    AddressesDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressesDataModelToJson(AddressesDataModel instance) =>
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

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phoneNo: (json['phoneNo'] as num?)?.toInt(),
      city: json['city'] as String?,
      zone: json['zone'] as String?,
      street: json['street'] as String?,
      notes: json['notes'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'city': instance.city,
      'zone': instance.zone,
      'street': instance.street,
      'notes': instance.notes,
      'type': instance.type,
      'createdAt': instance.createdAt,
    };
