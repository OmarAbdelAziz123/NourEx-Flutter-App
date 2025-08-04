// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDataModel _$ProfileDataModelFromJson(Map<String, dynamic> json) =>
    ProfileDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProfileUserModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileDataModelToJson(ProfileDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ProfileUserModel _$ProfileUserModelFromJson(Map<String, dynamic> json) =>
    ProfileUserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$ProfileUserModelToJson(ProfileUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'age': instance.age,
      'gender': instance.gender,
      'profilePic': instance.profilePic,
    };
