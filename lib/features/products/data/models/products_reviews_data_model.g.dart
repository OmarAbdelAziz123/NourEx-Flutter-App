// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_reviews_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsReviewsDataModel _$ProductsReviewsDataModelFromJson(
        Map<String, dynamic> json) =>
    ProductsReviewsDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ProductReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsReviewsDataModelToJson(
        ProductsReviewsDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'pagination': instance.pagination,
      'reviews': instance.reviews,
    };

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
      total: (json['total'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      pages: (json['pages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'pages': instance.pages,
    };

ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) =>
    ProductReview(
      id: json['_id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      myReview: json['myReview'] as bool?,
      user: json['user'] == null
          ? null
          : ReviewUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductReviewToJson(ProductReview instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'myReview': instance.myReview,
      'user': instance.user,
    };

ReviewUser _$ReviewUserFromJson(Map<String, dynamic> json) => ReviewUser(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$ReviewUserToJson(ReviewUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
    };
