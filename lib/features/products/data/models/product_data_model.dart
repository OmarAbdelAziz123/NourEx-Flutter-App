// class ProductDataModel {
//   final String productName;
//   final String productImage;
//   final String productRate;
//   final String productPriceBefore;
//   final String countOfNumber;
//   final String productPriceAfter;
//
//   ProductDataModel({
//     required this.productName,
//     required this.productImage,
//     required this.productRate,
//     required this.countOfNumber,
//     required this.productPriceBefore,
//     required this.productPriceAfter,
//   });
// }

import 'package:json_annotation/json_annotation.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';

part 'product_data_model.g.dart';

@JsonSerializable()
class ProductDataModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'pagination')
  Pagination? pagination;

  @JsonKey(name: 'result')
  List<ProductModel>? result;

  ProductDataModel({this.status, this.pagination, this.result});

  factory ProductDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataModelToJson(this);
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

  Pagination({this.total, this.page, this.size, this.pages});

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'sku')
  String? sku;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'mainImageURL')
  String? mainImageURL;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  ProductModel({
    this.id,
    this.sku,
    this.name,
    this.mainImageURL,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  static ProductModel convertMyOrderProductToProductModel(MyOrderProduct orderProduct) {
    return ProductModel(
      id: orderProduct.variants?.first.id,
      sku: orderProduct.variants?.first.sku,
      name: orderProduct.name,
      mainImageURL: orderProduct.mainImageURL,
      createdAt: null, // أو ضع التاريخ إن كان متاحًا في مكان آخر
    );
  }
}
