// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_support_ticket_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllSupportTicketDataModel _$GetAllSupportTicketDataModelFromJson(
        Map<String, dynamic> json) =>
    GetAllSupportTicketDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : PaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => SupportDModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllSupportTicketDataModelToJson(
        GetAllSupportTicketDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pagination': instance.pagination,
      'result': instance.result,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'pages': instance.pages,
    };

SupportDModel _$SupportDModelFromJson(Map<String, dynamic> json) =>
    SupportDModel(
      id: json['_id'] as String?,
      messageType: json['messageType'] as String?,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      ticketSeq: json['ticketSeq'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SupportDModelToJson(SupportDModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'messageType': instance.messageType,
      'content': instance.content,
      'images': instance.images,
      'ticketSeq': instance.ticketSeq,
      'status': instance.status,
    };
