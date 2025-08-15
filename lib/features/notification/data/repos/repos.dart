import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/notification/data/api_services/api_services.dart';
import 'package:nourex/features/notification/data/models/all_notifications_data_model.dart';

class NotificationRepos {
  final NotificationApiServices notificationApiServices;

  NotificationRepos(this.notificationApiServices);

  /// Get All Notifications
  Future<ApiResult<AllNotificationsDataModel>> getAllNotifications({
    required int page,
  }) async {
    try {
      final response = await notificationApiServices.getAllNotifications(page: page);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        final data = AllNotificationsDataModel.fromJson(response.data);
        return ApiResult.success(data);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              AllNotificationsDataModel>(response);
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
      return ApiResult.failure(ErrorHandler.handleApiError(e));
    }
  }
}
