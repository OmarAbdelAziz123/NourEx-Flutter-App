// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_notifications_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllNotificationsDataModel _$AllNotificationsDataModelFromJson(
        Map<String, dynamic> json) =>
    AllNotificationsDataModel(
      status: json['status'] as String?,
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllNotificationsDataModelToJson(
        AllNotificationsDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'pages': instance.pages,
      'result': instance.result?.map((e) => e.toJson()).toList(),
    };

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: json['_id'] as String?,
      message: json['message'] as String?,
      description: json['description'] as String?,
      time: json['time'] as String?,
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'description': instance.description,
      'time': instance.time,
      'isRead': instance.isRead,
    };
