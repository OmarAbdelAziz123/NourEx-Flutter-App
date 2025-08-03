import 'package:json_annotation/json_annotation.dart';

part 'products_reviews_data_model.g.dart';

@JsonSerializable()
class ProductsReviewsDataModel {
  final String? status;
  final Pagination? pagination;
  final List<ProductReview>? reviews;

  ProductsReviewsDataModel({
    this.status,
    this.pagination,
    this.reviews,
  });

  factory ProductsReviewsDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsReviewsDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsReviewsDataModelToJson(this);
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
class ProductReview {
  @JsonKey(name: '_id')
  final String? id;
  final double? rating;
  final String? comment;
  final String? createdAt;
  final bool? myReview;
  final ReviewUser? user;

  ProductReview({
    this.id,
    this.rating,
    this.comment,
    this.createdAt,
    this.myReview,
    this.user,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}

@JsonSerializable()
class ReviewUser {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? profilePic;

  ReviewUser({
    this.id,
    this.name,
    this.email,
    this.profilePic,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) =>
      _$ReviewUserFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewUserToJson(this);
}
