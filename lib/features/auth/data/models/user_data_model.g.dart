// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      message: json['message'] as String?,
      authorization: json['authorization'] == null
          ? null
          : Authorization.fromJson(
              json['authorization'] as Map<String, dynamic>),
      result: json['result'] == null
          ? null
          : UserModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'authorization': instance.authorization,
      'result': instance.result,
    };

Authorization _$AuthorizationFromJson(Map<String, dynamic> json) =>
    Authorization(
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthorizationToJson(Authorization instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['imageUrl'] as String?,
      station: json['station'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      isActive: json['isActive'] as bool?,
      employeeCode: json['employeeCode'] as String?,
      availability: json['availability'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'imageUrl': instance.imageUrl,
      'station': instance.station,
      'role': instance.role,
      'status': instance.status,
      'isActive': instance.isActive,
      'employeeCode': instance.employeeCode,
      'availability': instance.availability,
      'updatedAt': instance.updatedAt,
    };
