// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ticket_details_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTicketDetailsDataModel _$GetTicketDetailsDataModelFromJson(
        Map<String, dynamic> json) =>
    GetTicketDetailsDataModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TicketDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetTicketDetailsDataModelToJson(
        GetTicketDetailsDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

TicketDetailModel _$TicketDetailModelFromJson(Map<String, dynamic> json) =>
    TicketDetailModel(
      id: json['_id'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isMine: json['isMine'] as bool?,
      senderType: json['senderType'] as String?,
      createdAt: json['createdAt'] as String?,
      createdDateTime: json['createdDateTime'] as String?,
      isTicketMessage: json['isTicketMessage'] as bool?,
    );

Map<String, dynamic> _$TicketDetailModelToJson(TicketDetailModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'messageType': instance.messageType,
      'content': instance.content,
      'images': instance.images,
      'isMine': instance.isMine,
      'senderType': instance.senderType,
      'createdAt': instance.createdAt,
      'createdDateTime': instance.createdDateTime,
      'isTicketMessage': instance.isTicketMessage,
    };
