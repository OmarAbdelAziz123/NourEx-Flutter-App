import 'package:json_annotation/json_annotation.dart';

part 'all_notifications_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AllNotificationsDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'pages')
  int? pages;

  @JsonKey(name: 'result')
  List<NotificationItem>? result;

  AllNotificationsDataModel({
    this.status,
    this.total,
    this.page,
    this.size,
    this.pages,
    this.result,
  });

  factory AllNotificationsDataModel.fromJson(Map<String, dynamic> json) =>
      _$AllNotificationsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllNotificationsDataModelToJson(this);
}

@JsonSerializable()
class NotificationItem {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'time')
  String? time;

  @JsonKey(name: 'isRead')
  bool? isRead;

  NotificationItem({
    this.id,
    this.message,
    this.description,
    this.time,
    this.isRead,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}
