import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/cart/data/api_services/api_services.dart';
import 'package:nourex/features/cart/data/models/apply_coupon_data_model.dart';
import 'package:nourex/features/cart/data/models/cart_data_model.dart';
import 'package:nourex/features/cart/data/models/main_address_data_model.dart';
import 'package:nourex/features/cart/data/models/make_order_response_model.dart';

class CartRepos {
  final CartApiServices cartApiServices;

  CartRepos(this.cartApiServices);

  /// Add Product To Cart
  Future<ApiResult<String>> addProductToCart({
    required String productId,
    required int quantity,
    required String variantSku,
  }) async {
    try {
      final response = await cartApiServices.addProductToCart(
        productId: productId,
        quantity: quantity,
        variantSku: variantSku,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
              response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Get Cart
  Future<ApiResult<CartDataModel>> getCart() async {
    try {
      final response = await cartApiServices.getCart();
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        CartDataModel cartDataModel = CartDataModel.fromJson(response.data);

        return ApiResult.success(cartDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              CartDataModel>(response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Remove Product From Cart
  Future<ApiResult<String>> removeProductFromCart({
    required String productId,
    required String variantSku,
  }) async {
    try {
      final response = await cartApiServices.removeProductFromCart(
        productId: productId,
        variantSku: variantSku,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
              response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Update Product From Cart
  Future<ApiResult<String>> updateProductFromCart({
    required String productId,
    required String variantSku,
    required int amount,
  }) async {
    try {
      final response = await cartApiServices.updateCart(
        productId: productId,
        variantSku: variantSku,
        amount: amount,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
              response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Apply Coupon
  Future<ApiResult<AppLyCouponDataModel>> applyCoupon({
    required String cartTotal,
    required String couponName,
  }) async {
    try {
      final response = await cartApiServices.applyCoupon(
        cartTotal: cartTotal,
        couponName: couponName,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        AppLyCouponDataModel appLyCouponDataModel =
            AppLyCouponDataModel.fromJson(response.data);

        return ApiResult.success(appLyCouponDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              AppLyCouponDataModel>(response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Get Main Address
  Future<ApiResult<MainAddressDataModel>> getMainAddress() async {
    try {
      final response = await cartApiServices.getMainAddress();
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        MainAddressDataModel mainAddressDataModel =
            MainAddressDataModel.fromJson(response.data);
        return ApiResult.success(mainAddressDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              MainAddressDataModel>(response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Make Order
  Future<ApiResult<MakeOrderResponseModel>> makeOrder({
    required String paymentMethod,
    String? coupon,
    String? couponCode,
    required String address,
    String? notes,
  }) async {
    try {
      final response = await cartApiServices.makeOrder(
        paymentMethod: paymentMethod,
        coupon: coupon,
        couponCode: couponCode,
        address: address,
        notes: notes,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        MakeOrderResponseModel makeOrderResponseModel =
            MakeOrderResponseModel.fromJson(response.data);
        return ApiResult.success(makeOrderResponseModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<MakeOrderResponseModel>(
              response);
        } else {
          ToastManager.showCustomToast(
            message: response.data['message'],
            backgroundColor: AppColors.redColor200,
            icon: Icons.error_outline,
            duration: const Duration(seconds: 3),
          );
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}
