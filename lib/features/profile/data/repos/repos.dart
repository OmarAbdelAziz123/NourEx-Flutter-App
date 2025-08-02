import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/profile/data/api_services/api_services.dart';
import 'package:nourex/features/profile/data/models/profile/profile_data_model.dart';
import 'package:nourex/features/profile/data/models/reviews/my_reviews_data_model.dart';

import '../../../../core/networks_helper/errors/error_handler.dart';

class ProfileRepos {
  final ProfileApiServices profileApiServices;

  ProfileRepos(this.profileApiServices);

  /// Get Profile
  Future<ApiResult<ProfileDataModel>> getProfile() async {
    try {
      final response = await profileApiServices.getProfile();

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.success(ProfileDataModel.fromJson(response.data));
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<ProfileDataModel>(response);
        } else {
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Update Profile
  Future<ApiResult<String>> updateProfile(
    String? name,
    String? email,
    String? phone,
    String? age,
    File? profileImage,
  ) async {
    try {
      final response = await profileApiServices.updateProfile(
        name,
        email,
        phone,
        age,
        profileImage,
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

        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(response);
        } else {
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Get All My Reviews
  Future<ApiResult<MyReviewsDataModel>> getAllMyReviews({required int page}) async {
    try {
      final response = await profileApiServices.getAllMyReviews(page: page);

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        MyReviewsDataModel myReviewsDataModel = MyReviewsDataModel.fromJson(response.data);
        return ApiResult.success(myReviewsDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<MyReviewsDataModel>(response);
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
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Delete My Review
  Future<ApiResult<String>> deleteMyReview(String productId, String reviewId) async {
    try {
      final response = await profileApiServices.deleteMyReview(productId, reviewId);

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
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(response);
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
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Update My Review
  Future<ApiResult<String>> updateMyReview(String productId, String reviewId, String comment, double rating) async {
    try {
      final response = await profileApiServices.updateMyReview(productId, reviewId, comment, rating);

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
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(response);
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
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

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
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(response);
        } else {
          return ApiResult.failure(ErrorHandler.handleApiError(response));
        }
      }
    } on DioException catch (e) {
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}