import 'package:json_annotation/json_annotation.dart';

part 'make_support_response_data_model.g.dart';

@JsonSerializable()
class SupportResponseModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  SupportModel? data;

  SupportResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory SupportResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SupportResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportResponseModelToJson(this);
}

@JsonSerializable()
class SupportModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'customId')
  String? customId;

  @JsonKey(name: 'senderId')
  SenderModel? senderId;

  @JsonKey(name: 'messageType')
  String? messageType;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'images')
  List<String>? images;

  @JsonKey(name: 'ticketSeq')
  String? ticketSeq;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'isDeleted')
  bool? isDeleted;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  @JsonKey(name: '__v')
  int? version;

  SupportModel({
    this.id,
    this.customId,
    this.senderId,
    this.messageType,
    this.content,
    this.images,
    this.ticketSeq,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportModelToJson(this);
}

@JsonSerializable()
class SenderModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'profilePic')
  String? profilePic;

  SenderModel({
    this.id,
    this.name,
    this.email,
    this.profilePic,
  });

  factory SenderModel.fromJson(Map<String, dynamic> json) =>
      _$SenderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SenderModelToJson(this);
}