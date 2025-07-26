import 'package:json_annotation/json_annotation.dart';

part 'category_data_model.g.dart';

@JsonSerializable()
class CategoryDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'pagination')
  Pagination? pagination;

  @JsonKey(name: 'result')
  List<CategoryModel>? result;

  CategoryDataModel({
    this.status,
    this.pagination,
    this.result,
  });

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataModelToJson(this);
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
class CategoryModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'createdBy')
  String? createdBy;

  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.createdBy,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
