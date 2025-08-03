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
  Future<Response?> getProductReviews({required String productId, required int page}) async {
    return await _dioFactory.get(
      endPoint: '${EndPoints.productReviews}/$productId',
      data: {
        'page': page
      }
    );
  }
}
