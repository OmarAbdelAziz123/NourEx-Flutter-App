import 'package:json_annotation/json_annotation.dart';

part 'returned_orders_data_model.g.dart';

@JsonSerializable()
class ReturnedOrdersDataModel {
  final String? status;
  final Pagination? pagination;
  final List<ReturnedOrder>? result;

  ReturnedOrdersDataModel({
    this.status,
    this.pagination,
    this.result,
  });

  factory ReturnedOrdersDataModel.fromJson(Map<String, dynamic> json) =>
      _$ReturnedOrdersDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedOrdersDataModelToJson(this);
}

@JsonSerializable()
class ReturnedOrder {
  @JsonKey(name: '_id')
  final String? id;
  final String? reason;
  final String? returnSeq;
  final List<String>? imageURLs;
  final String? createdAt;
  final List<ReturnedProduct>? products;
  final ReturnedOrderMetaOrder? order;
  final ReturnedOrderAddress? address;

  ReturnedOrder({
    this.id,
    this.reason,
    this.returnSeq,
    this.imageURLs,
    this.createdAt,
    this.products,
    this.order,
    this.address,
  });

  factory ReturnedOrder.fromJson(Map<String, dynamic> json) =>
      _$ReturnedOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedOrderToJson(this);
}

@JsonSerializable()
class ReturnedProduct {
  final String? productId;
  final String? variantSku;
  final String? status;
  final String? name;
  final String? mainImageURL;
  final String? description;
  final int? averageRating;
  final int? totalOrderCount;
  final ReturnedVendor? vendor;

  ReturnedProduct({
    this.description,
    this.averageRating,
    this.productId,
    this.totalOrderCount,
    this.variantSku,
    this.status,
    this.name,
    this.mainImageURL,
    this.vendor,
  });

  factory ReturnedProduct.fromJson(Map<String, dynamic> json) =>
      _$ReturnedProductFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedProductToJson(this);
}

@JsonSerializable()
class ReturnedVendor {
  @JsonKey(name: '_id')
  final String? id;
  final String? storeName;
  final String? email;
  final String? phone;

  ReturnedVendor({
    this.id,
    this.storeName,
    this.email,
    this.phone,
  });

  factory ReturnedVendor.fromJson(Map<String, dynamic> json) =>
      _$ReturnedVendorFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedVendorToJson(this);
}

@JsonSerializable()
class ReturnedOrderMetaOrder {
  @JsonKey(name: '_id')
  final String? id;
  final String? orderSeq;
  final String? status;

  ReturnedOrderMetaOrder({
    this.id,
    this.orderSeq,
    this.status,
  });

  factory ReturnedOrderMetaOrder.fromJson(Map<String, dynamic> json) =>
      _$ReturnedOrderMetaOrderFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedOrderMetaOrderToJson(this);
}

@JsonSerializable()
class ReturnedOrderAddress {
  final int? phoneNo;
  final String? city;
  final String? zone;
  final String? street;
  final String? notes;

  ReturnedOrderAddress({
    this.phoneNo,
    this.city,
    this.zone,
    this.street,
    this.notes,
  });

  factory ReturnedOrderAddress.fromJson(Map<String, dynamic> json) =>
      _$ReturnedOrderAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnedOrderAddressToJson(this);
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
