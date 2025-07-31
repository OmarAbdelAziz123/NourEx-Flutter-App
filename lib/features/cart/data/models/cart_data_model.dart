import 'package:json_annotation/json_annotation.dart';

part 'cart_data_model.g.dart';

@JsonSerializable()
class CartDataModel {
  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'result')
  final CartResult? result;

  CartDataModel({
    this.status,
    this.message,
    this.result,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) =>
      _$CartDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataModelToJson(this);
}

@JsonSerializable()
class CartResult {
  @JsonKey(name: 'products')
  final List<CartProduct>? products;

  @JsonKey(name: 'totalPrice')
  final int? totalPrice;

  CartResult({
    this.products,
    this.totalPrice,
  });

  factory CartResult.fromJson(Map<String, dynamic> json) =>
      _$CartResultFromJson(json);

  Map<String, dynamic> toJson() => _$CartResultToJson(this);
}

@JsonSerializable()
class CartProduct {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'productId')
  final String? productId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'mainImageURL')
  final String? mainImageURL;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'finalPrice')
  final int? finalPrice;

  @JsonKey(name: 'variantSku')
  final String? variantSku;

  @JsonKey(name: 'variantAttributes')
  final List<VariantAttribute>? variantAttributes;

  @JsonKey(name: 'itemTotal')
  final int? itemTotal;

  CartProduct({
    this.id,
    this.productId,
    this.name,
    this.mainImageURL,
    this.quantity,
    this.finalPrice,
    this.variantSku,
    this.variantAttributes,
    this.itemTotal,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);

  /// ✅ Custom Getter
  int get discount {
    if (itemTotal == null || quantity == null || finalPrice == null) return 0;
    return itemTotal! - (finalPrice! * quantity!);
  }
}

@JsonSerializable()
class VariantAttribute {
  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'value')
  final String? value;

  @JsonKey(name: '_id')
  final String? id;

  VariantAttribute({
    this.name,
    this.value,
    this.id,
  });

  factory VariantAttribute.fromJson(Map<String, dynamic> json) =>
      _$VariantAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$VariantAttributeToJson(this);
}
