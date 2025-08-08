// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_support_response_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportResponseModel _$SupportResponseModelFromJson(
        Map<String, dynamic> json) =>
    SupportResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : SupportModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SupportResponseModelToJson(
        SupportResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

SupportModel _$SupportModelFromJson(Map<String, dynamic> json) => SupportModel(
      id: json['_id'] as String?,
      customId: json['customId'] as String?,
      senderId: json['senderId'] == null
          ? null
          : SenderModel.fromJson(json['senderId'] as Map<String, dynamic>),
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ticketSeq: json['ticketSeq'] as String?,
      status: json['status'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SupportModelToJson(SupportModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'customId': instance.customId,
      'senderId': instance.senderId,
      'messageType': instance.messageType,
      'content': instance.content,
      'images': instance.images,
      'ticketSeq': instance.ticketSeq,
      'status': instance.status,
      'isDeleted': instance.isDeleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };

SenderModel _$SenderModelFromJson(Map<String, dynamic> json) => SenderModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$SenderModelToJson(SenderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
    };
