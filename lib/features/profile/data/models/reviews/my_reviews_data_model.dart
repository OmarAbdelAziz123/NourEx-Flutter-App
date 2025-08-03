import 'package:json_annotation/json_annotation.dart';

part 'my_reviews_data_model.g.dart';

@JsonSerializable()
class MyReviewsDataModel {
  final String? status;
  final Pagination? pagination;
  final List<MyReview>? reviews;

  MyReviewsDataModel({
    this.status,
    this.pagination,
    this.reviews,
  });

  factory MyReviewsDataModel.fromJson(Map<String, dynamic> json) =>
      _$MyReviewsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewsDataModelToJson(this);
}

@JsonSerializable()
class Pagination {
  final int? total;
  final int? page;
  final int? size;
  final int? pages;

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
class MyReview {
  @JsonKey(name: '_id')
  final String? id;
  final double? rating;
  final String? comment;
  final String? createdAt;
  final MyReviewUser? user;
  final MyReviewProduct? product;

  MyReview({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.user,
    this.product,
  });

  factory MyReview.fromJson(Map<String, dynamic> json) =>
      _$MyReviewFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewToJson(this);
}

@JsonSerializable()
class MyReviewUser {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? profilePic;

  MyReviewUser({
    this.id,
    this.name,
    this.email,
    this.profilePic,
  });

  factory MyReviewUser.fromJson(Map<String, dynamic> json) =>
      _$MyReviewUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewUserToJson(this);
}

@JsonSerializable()
class MyReviewProduct {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? mainImageURL;

  MyReviewProduct({
    this.id,
    this.name,
    this.mainImageURL,
  });

  factory MyReviewProduct.fromJson(Map<String, dynamic> json) =>
      _$MyReviewProductFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewProductToJson(this);
}
