import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/banners/data/api_services/api_services.dart';
import 'package:nourex/features/banners/data/models/banners_data_model.dart';

class BannersRepos {
  final BannersApiServices bannersApiServices;

  BannersRepos(this.bannersApiServices);

  /// Get All Banners
  Future<ApiResult<BannersDataModel>> getAllBanners({required int page}) async {
    try {
      final response = await bannersApiServices.getAllBanners(page: page);

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200) {
        final data = BannersDataModel.fromJson(response.data);
        return ApiResult.success(data);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<BannersDataModel>(
            response,
          );
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