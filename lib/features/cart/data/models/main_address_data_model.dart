import 'package:json_annotation/json_annotation.dart';

part 'main_address_data_model.g.dart';

@JsonSerializable()
class MainAddressDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'result')
  AddressModel? result;

  MainAddressDataModel({
    this.status,
    this.message,
    this.result,
  });

  factory MainAddressDataModel.fromJson(Map<String, dynamic> json) =>
      _$MainAddressDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainAddressDataModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'phoneNo')
  int? phoneNo;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'zone')
  String? zone;

  @JsonKey(name: 'street')
  String? street;

  @JsonKey(name: 'notes')
  String? notes;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'isDeleted')
  bool? isDeleted;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  AddressModel({
    this.id,
    this.userId,
    this.name,
    this.phoneNo,
    this.city,
    this.zone,
    this.street,
    this.notes,
    this.type,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
