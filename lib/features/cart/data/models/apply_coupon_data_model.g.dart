// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_coupon_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppLyCouponDataModel _$AppLyCouponDataModelFromJson(
        Map<String, dynamic> json) =>
    AppLyCouponDataModel(
      status: json['status'] as String?,
      discount: (json['discount'] as num?)?.toInt(),
      discountAmount: (json['discountAmount'] as num?)?.toInt(),
      newTotal: (json['newTotal'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppLyCouponDataModelToJson(
        AppLyCouponDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'discount': instance.discount,
      'discountAmount': instance.discountAmount,
      'newTotal': instance.newTotal,
    };
