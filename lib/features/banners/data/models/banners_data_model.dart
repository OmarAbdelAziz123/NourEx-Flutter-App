import 'package:json_annotation/json_annotation.dart';

part 'banners_data_model.g.dart';

@JsonSerializable()
class BannersDataModel {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'pagination')
  Pagination? pagination;

  @JsonKey(name: 'banners')
  List<BannerModel>? banners;

  BannersDataModel({
    this.message,
    this.pagination,
    this.banners,
  });

  factory BannersDataModel.fromJson(Map<String, dynamic> json) =>
      _$BannersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannersDataModelToJson(this);
}

@JsonSerializable()
class BannerModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'product')
  ProductInfo? product;

  @JsonKey(name: 'startDate')
  String? startDate;

  @JsonKey(name: 'expireDate')
  String? expireDate;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'customId')
  String? customId;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  BannerModel({
    this.id,
    this.product,
    this.startDate,
    this.expireDate,
    this.image,
    this.customId,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

@JsonSerializable()
class ProductInfo {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  ProductInfo({
    this.id,
    this.name,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
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
