// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      status: json['status'] as String?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'result': instance.result?.toJson(),
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      sId: json['_id'] as String?,
      customId: json['customId'] as String?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      mainImageURL: json['mainImageURL'] as String?,
      subImages: (json['subImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      categoryId: json['categoryId'] as String?,
      showProduct: json['showProduct'] as bool?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      availableVariants: (json['availableVariants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variants.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
    )..isRated = json['isRated'] as bool?;

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      '_id': instance.sId,
      'customId': instance.customId,
      'isRated': instance.isRated,
      'sku': instance.sku,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'mainImageURL': instance.mainImageURL,
      'subImages': instance.subImages,
      'categoryId': instance.categoryId,
      'showProduct': instance.showProduct,
      'tags': instance.tags,
      'availableVariants': instance.availableVariants,
      'variants': instance.variants?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
    };

Variants _$VariantsFromJson(Map<String, dynamic> json) => Variants(
      skuId: (json['skuId'] as num?)?.toInt(),
      sku: json['sku'] as String?,
      stockAmount: (json['stockAmount'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      priceAfterDiscount: (json['priceAfterDiscount'] as num?)?.toInt(),
      discountRounded: (json['discountRounded'] as num?)?.toInt(),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => Attributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      sId: json['_id'] as String?,
    );

Map<String, dynamic> _$VariantsToJson(Variants instance) => <String, dynamic>{
      'skuId': instance.skuId,
      'sku': instance.sku,
      'stockAmount': instance.stockAmount,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'discountRounded': instance.discountRounded,
      'attributes': instance.attributes,
      '_id': instance.sId,
    };

Attributes _$AttributesFromJson(Map<String, dynamic> json) => Attributes(
      name: json['name'] as String?,
      value: json['value'] as String?,
      sId: json['_id'] as String?,
    );

Map<String, dynamic> _$AttributesToJson(Attributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      '_id': instance.sId,
    };
