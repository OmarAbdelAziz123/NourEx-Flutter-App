import 'package:json_annotation/json_annotation.dart';

part 'apply_coupon_data_model.g.dart';

@JsonSerializable()
class AppLyCouponDataModel {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'discount')
  final int? discount;

  @JsonKey(name: 'discountAmount')
  final int? discountAmount;

  @JsonKey(name: 'newTotal')
  final int? newTotal;

  AppLyCouponDataModel({
    this.status,
    this.discount,
    this.discountAmount,
    this.newTotal,
  });

  factory AppLyCouponDataModel.fromJson(Map<String, dynamic> json) =>
      _$AppLyCouponDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppLyCouponDataModelToJson(this);
}
