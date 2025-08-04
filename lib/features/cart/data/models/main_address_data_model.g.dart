// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_address_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainAddressDataModel _$MainAddressDataModelFromJson(
        Map<String, dynamic> json) =>
    MainAddressDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : AddressModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MainAddressDataModelToJson(
        MainAddressDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'result': instance.result,
    };

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      phoneNo: (json['phoneNo'] as num?)?.toInt(),
      city: json['city'] as String?,
      zone: json['zone'] as String?,
      street: json['street'] as String?,
      notes: json['notes'] as String?,
      type: json['type'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'phoneNo': instance.phoneNo,
      'city': instance.city,
      'zone': instance.zone,
      'street': instance.street,
      'notes': instance.notes,
      'type': instance.type,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
