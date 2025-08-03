import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductDetailsModel {
  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'result')
  Result? result;

  ProductDetailsModel({this.status, this.result});

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Result {
  @JsonKey(name: '_id')
  String? sId;

  @JsonKey(name: 'customId')
  String? customId;

  @JsonKey(name: 'isRated')
  bool? isRated;

  @JsonKey(name: 'sku')
  String? sku;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'slug')
  String? slug;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'mainImageURL')
  String? mainImageURL;

  @JsonKey(name: 'subImages')
  List<String>? subImages;

  @JsonKey(name: 'categoryId')
  String? categoryId;

  @JsonKey(name: 'showProduct')
  bool? showProduct;

  @JsonKey(name: 'tags')
  List<String>? tags;

  @JsonKey(name: 'availableVariants')
  List<String>? availableVariants;

  @JsonKey(name: 'variants')
  List<Variants>? variants;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(ignore: true)
  Map<String, List<String?>> variantsMap = {};

  Result({
    this.sId,
    this.customId,
    this.sku,
    this.name,
    this.slug,
    this.description,
    this.mainImageURL,
    this.subImages,
    this.categoryId,
    this.showProduct,
    this.tags,
    this.availableVariants,
    this.variants,
    this.createdAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  Map<String, List<String?>> addInvariantsMap() {
    variantsMap.clear();

    for (var element in availableVariants ?? []) {
      var listOfStringAttributes = variants
          ?.map((variant) {
        var matchingAttribute = variant.attributes?.firstWhere(
              (attr) => attr.name == element,
          orElse: () => Attributes(),
        );
        return matchingAttribute?.value;
      })
          .where((value) => value != null)
          .toList();

      variantsMap[element] = listOfStringAttributes ?? [];
    }

    return variantsMap;
  }
}

@JsonSerializable()
class Variants {
  @JsonKey(name: 'skuId')
  int? skuId;

  @JsonKey(name: 'sku')
  String? sku;

  @JsonKey(name: 'stockAmount')
  int? stockAmount;

  @JsonKey(name: 'price')
  int? price;

  @JsonKey(name: 'priceAfterDiscount')
  int? priceAfterDiscount;

  @JsonKey(name: 'discountRounded')
  int? discountRounded;

  @JsonKey(name: 'attributes')
  List<Attributes>? attributes;

  @JsonKey(name: '_id')
  String? sId;

  Variants({
    this.skuId,
    this.sku,
    this.stockAmount,
    this.price,
    this.priceAfterDiscount,
    this.discountRounded,
    this.attributes,
    this.sId,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => _$VariantsFromJson(json);

  Map<String, dynamic> toJson() => _$VariantsToJson(this);
}

@JsonSerializable()
class Attributes {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: '_id')
  String? sId;

  Attributes({this.name, this.value, this.sId});

  factory Attributes.fromJson(Map<String, dynamic> json) => _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);
}