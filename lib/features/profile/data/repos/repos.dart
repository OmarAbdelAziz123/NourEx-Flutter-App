import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/profile/data/api_services/api_services.dart';

import '../../../../core/networks_helper/errors/error_handler.dart';

class ProfileRepos {
  final ProfileApiServices profileApiServices;

  ProfileRepos(this.profileApiServices);

  /// Logout
  Future<ApiResult<String>> userLogout() async {
    try {
      final response = await profileApiServices.userLogout();

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

        return ApiResult.success(response.data['message']);
      } else {
        return ApiResult.failure(ErrorHandler.handleApiError(response));
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}