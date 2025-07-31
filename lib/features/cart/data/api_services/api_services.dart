import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class CartApiServices {
  final DioHelper _dioFactory;

  CartApiServices(this._dioFactory);

  /// Add Product To Cart
  Future<Response?> addProductToCart({
    required String productId,
    required int quantity,
    required String variantSku,
  }) async {
    return await _dioFactory.post(endPoint: EndPoints.addProductToCart, data: {
      "productId": productId,
      "quantity": quantity,
      "variantSku": variantSku,
    });
  }

  /// Remove Product From Cart
  Future<Response?> removeProductFromCart({
    required String productId,
    required String variantSku,
  }) async {
    return await _dioFactory.patch(
      endPoint: EndPoints.removeProductFromCart,
      data: {
        "productItems": [
          {
            "productId": productId,
            "variantSku": variantSku,
          }
        ]
      },
    );
  }

  /// Remove All Product From Cart
  Future<Response?> removeAllProductsFromCart() async {
    return await _dioFactory.post(
        endPoint: EndPoints.removeAllProductsFromCart);
  }

  /// Get Cart
  Future<Response?> getCart() async {
    return await _dioFactory.get(endPoint: EndPoints.getCart);
  }

  /// Update Cart
  Future<Response?> updateCart({
    required String productId,
    required String variantSku,
    required int amount,
  }) async {
    return await _dioFactory.patch(endPoint: EndPoints.updateCart, data: {
      "productId": productId,
      "variantSku": variantSku,
      "amount": amount,
    });
  }
}
