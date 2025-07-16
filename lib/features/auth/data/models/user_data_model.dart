import 'package:json_annotation/json_annotation.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'authorization')
  Authorization? authorization;

  @JsonKey(name: 'result')
  UserModel? result;

  UserDataModel({this.message, this.authorization, this.result});

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

@JsonSerializable()
class Authorization {
  @JsonKey(name: 'token')
  String? token;

  Authorization({this.token});

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);
}

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'name')
  String? name; // <-- تم التعديل: كان UserName وأصبح String

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'imageUrl')
  String? imageUrl;

  @JsonKey(name: 'station')
  String? station;

  @JsonKey(name: 'role')
  String? role;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'isActive')
  bool? isActive;

  @JsonKey(name: 'employeeCode')
  String? employeeCode;

  @JsonKey(name: 'availability')
  String? availability;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.station,
    this.role,
    this.status,
    this.isActive,
    this.employeeCode,
    this.availability,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
