import 'package:json_annotation/json_annotation.dart';

part 'profile_data_model.g.dart';

@JsonSerializable()
class ProfileDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  ProfileUserModel? data;

  ProfileDataModel({this.status, this.message, this.data});

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDataModelToJson(this);
}

@JsonSerializable()
class ProfileUserModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'age')
  int? age;

  @JsonKey(name: 'gender')
  String? gender;

  @JsonKey(name: 'profilePic')
  String? profilePic;

  ProfileUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.age,
    this.gender,
    this.profilePic,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUserModelToJson(this);
}
