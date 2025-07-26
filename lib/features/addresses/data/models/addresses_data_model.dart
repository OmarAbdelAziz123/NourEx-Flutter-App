// class AddressesDataModel {
//   final String addressesName;
//   final List<String> addressesData;
//
//   AddressesDataModel({
//     required this.addressesName,
//     required this.addressesData,
//   });
// }

import 'package:json_annotation/json_annotation.dart';

part 'addresses_data_model.g.dart';

@JsonSerializable()
class AddressesDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'pagination')
  Pagination? pagination;

  @JsonKey(name: 'result')
  List<AddressModel>? result;

  AddressesDataModel({
    this.status,
    this.pagination,
    this.result,
  });

  factory AddressesDataModel.fromJson(Map<String, dynamic> json) =>
      _$AddressesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressesDataModelToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(name: 'pages')
  int? pages;

  Pagination({
    this.total,
    this.page,
    this.size,
    this.pages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class AddressModel {
  @JsonKey(name: '_id')
  String? id;

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

  @JsonKey(name: 'createdAt')
  String? createdAt;

  AddressModel({
    this.id,
    this.name,
    this.phoneNo,
    this.city,
    this.zone,
    this.street,
    this.notes,
    this.type,
    this.createdAt,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
