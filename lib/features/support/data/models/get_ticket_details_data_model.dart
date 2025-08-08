import 'package:json_annotation/json_annotation.dart';

part 'get_ticket_details_data_model.g.dart';

@JsonSerializable()
class GetTicketDetailsDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'data')
  List<TicketDetailModel>? data;

  GetTicketDetailsDataModel({
    this.status,
    this.data,
  });

  factory GetTicketDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$GetTicketDetailsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetTicketDetailsDataModelToJson(this);
}

@JsonSerializable()
class TicketDetailModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'messageType')
  String? messageType;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'images')
  List<String>? images;

  @JsonKey(name: 'isMine')
  bool? isMine;

  @JsonKey(name: 'senderType')
  String? senderType;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'createdDateTime')
  String? createdDateTime;

  @JsonKey(name: 'isTicketMessage')
  bool? isTicketMessage;

  TicketDetailModel({
    this.id,
    this.messageType,
    this.content,
    this.images,
    this.isMine,
    this.senderType,
    this.createdAt,
    this.createdDateTime,
    this.isTicketMessage,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDetailModelToJson(this);
}