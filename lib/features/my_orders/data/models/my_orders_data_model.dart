import 'package:json_annotation/json_annotation.dart';

part 'my_orders_data_model.g.dart';

@JsonSerializable()
class MyOrdersDataModel {
  final String? status;
  final Pagination? pagination;
  final List<MyOrder>? result;

  MyOrdersDataModel({
    this.status,
    this.pagination,
    this.result,
  });

  factory MyOrdersDataModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrdersDataModelToJson(this);
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
class MyOrder {
  @JsonKey(name: '_id')
  final String? id;
  final String? orderSeq;
  final String? createdAt;
  final String? status;
  final String? paymentType;
  final List<MyOrderProduct>? products;
  final MyOrderAddress? address;
  final MyOrderUser? user; // ✅ تم الإضافة هنا

  MyOrder({
    this.id,
    this.orderSeq,
    this.createdAt,
    this.status,
    this.paymentType,
    this.products,
    this.address,
    this.user,
  });

  factory MyOrder.fromJson(Map<String, dynamic> json) =>
      _$MyOrderFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderToJson(this);
}

@JsonSerializable()
class MyOrderProduct {
  final String? productId;
  final double? finalProductTotal;
  final String? status;
  final String? mainImageURL;
  final String? name;
  final List<MyOrderVariant>? variants;

  MyOrderProduct({
    this.productId,
    this.finalProductTotal,
    this.status,
    this.mainImageURL,
    this.name,
    this.variants,
  });

  factory MyOrderProduct.fromJson(Map<String, dynamic> json) =>
      _$MyOrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderProductToJson(this);
}

@JsonSerializable()
class MyOrderVariant {
  final int? skuId;
  final String? itemSeq;
  final String? sku;
  final int? stockAmount;
  final int? price;
  final double? priceAfterDiscount;
  final int? discountRounded;
  final List<MyOrderAttribute>? attributes;
  @JsonKey(name: '_id')
  final String? id;

  MyOrderVariant({
    this.skuId,
    this.itemSeq,
    this.sku,
    this.stockAmount,
    this.price,
    this.priceAfterDiscount,
    this.discountRounded,
    this.attributes,
    this.id,
  });

  factory MyOrderVariant.fromJson(Map<String, dynamic> json) =>
      _$MyOrderVariantFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderVariantToJson(this);
}

@JsonSerializable()
class MyOrderAttribute {
  final String? name;
  final String? value;
  @JsonKey(name: '_id')
  final String? id;

  MyOrderAttribute({
    this.name,
    this.value,
    this.id,
  });

  factory MyOrderAttribute.fromJson(Map<String, dynamic> json) =>
      _$MyOrderAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderAttributeToJson(this);
}

@JsonSerializable()
class MyOrderUser {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  final String? phone;

  MyOrderUser({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory MyOrderUser.fromJson(Map<String, dynamic> json) =>
      _$MyOrderUserFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderUserToJson(this);
}

@JsonSerializable()
class MyOrderAddress {
  final String? city;
  final String? zone;
  final String? street;
  final String? notes;

  MyOrderAddress({
    this.city,
    this.zone,
    this.street,
    this.notes,
  });

  factory MyOrderAddress.fromJson(Map<String, dynamic> json) =>
      _$MyOrderAddressFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderAddressToJson(this);
}
