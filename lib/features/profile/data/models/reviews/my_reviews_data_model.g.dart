// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reviews_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReviewsDataModel _$MyReviewsDataModelFromJson(Map<String, dynamic> json) =>
    MyReviewsDataModel(
      status: json['status'] as String?,
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => MyReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyReviewsDataModelToJson(MyReviewsDataModel instance) =>
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

MyReview _$MyReviewFromJson(Map<String, dynamic> json) => MyReview(
      id: json['_id'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      user: json['user'] == null
          ? null
          : MyReviewUser.fromJson(json['user'] as Map<String, dynamic>),
      product: json['product'] == null
          ? null
          : MyReviewProduct.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyReviewToJson(MyReview instance) => <String, dynamic>{
      '_id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'user': instance.user,
      'product': instance.product,
    };

MyReviewUser _$MyReviewUserFromJson(Map<String, dynamic> json) => MyReviewUser(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      profilePic: json['profilePic'] as String?,
    );

Map<String, dynamic> _$MyReviewUserToJson(MyReviewUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'profilePic': instance.profilePic,
    };

MyReviewProduct _$MyReviewProductFromJson(Map<String, dynamic> json) =>
    MyReviewProduct(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
    );

Map<String, dynamic> _$MyReviewProductToJson(MyReviewProduct instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'mainImageURL': instance.mainImageURL,
    };
