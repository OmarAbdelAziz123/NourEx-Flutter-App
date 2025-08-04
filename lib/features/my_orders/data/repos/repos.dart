import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/my_orders/data/api_services/api_services.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';

import '../../../../core/networks_helper/errors/error_handler.dart';

class MyOrdersRepos {
  final MyOrdersApiServices myOrdersApiServices;

  MyOrdersRepos(this.myOrdersApiServices);

  /// Get All My Orders
  Future<ApiResult<MyOrdersDataModel>> getAllMyOrders(
      {required String status, required int page}) async {
    try {
      final response = await myOrdersApiServices.getAllMyOrders(
          status: status, page: page);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        MyOrdersDataModel myOrdersDataModel =
        MyOrdersDataModel.fromJson(response.data);
        return ApiResult.success(myOrdersDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              MyOrdersDataModel>(response);
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
      return ApiResult.failure(ErrorHandler.handleApiError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Make Return Order
  Future<ApiResult<String>> makeReturnOrder({
    required String orderId,
    required List<Map<String, String>> products,
    required List<XFile> returnImages,
    required String reason,
  }) async {
    try {
      final response = await myOrdersApiServices.makeReturnOrder(
        orderId: orderId,
        products: products,
        returnImages: returnImages,
        reason: reason,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastManager.showCustomToast(
          message: response.data['message'],
          backgroundColor: AppColors.greenColor200,
          icon: Icons.check_circle_outline,
          duration: const Duration(seconds: 3),
        );
        return ApiResult.success(response.data['message'].toString());
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
      return ApiResult.failure(ErrorHandler.handleApiError(e));
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}
