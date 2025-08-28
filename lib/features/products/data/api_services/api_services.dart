import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class ProductsApiServices {
  final DioHelper _dioFactory;

  ProductsApiServices(this._dioFactory);

  /// Get All Products
  Future<Response?> getAllProducts({required int page}) async {
    return await _dioFactory.get(endPoint: '${EndPoints.products}?page=$page');
  }

  /// Get All Best Offers
  // Future<Response?> getAllBestOffers({required int page, String? categoryId}) async {
  //   return await _dioFactory.get(endPoint: '${EndPoints.bestOffers}?page=$page');
  // }

  /// Get All Best Offers
  Future<Response?> getAllBestOffers(
      {required int page, String? categoryId}) async {
    final String endPoint =
        '${EndPoints.bestOffers}?page=$page${categoryId != null ? '&categoryId=$categoryId' : ''}';
    return await _dioFactory.get(endPoint: endPoint);
  }

  /// Get All Best Seller
  Future<Response?> getAllBestSeller(
      {required int page, String? categoryId}) async {
    final String endPoint =
        '${EndPoints.bestSeller}?page=$page${categoryId != null ? '&categoryId=$categoryId' : ''}';
    return await _dioFactory.get(endPoint: endPoint);
  }

  /// Get Products By Category
  Future<Response?> getProductsByCategory(
      {required int page, required String categoryId}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.productsByCategory}/$categoryId?page=$page');
  }

  /// Get Product By Id
  Future<Response?> getProductById({required String productId}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.productById}/$productId');
  }

  /// Get Product Reviews
  Future<Response?> getProductReviews(
      {required String productId, required int page}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.productReviews}/$productId',
        data: {'page': page});
  }

  /// Make Review
  Future<Response?> makeReview({
    required String productId,
    required String comment,
    required int rating,
  }) async {
    return await _dioFactory.post(
        endPoint: EndPoints.createReview(productId),
        data: {
          "comment": comment,
          "rating": rating,
        });
  }
}
