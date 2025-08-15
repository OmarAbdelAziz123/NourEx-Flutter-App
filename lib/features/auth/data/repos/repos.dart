import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/log_util.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/auth/data/api_services/api_services.dart';
import 'package:nourex/features/auth/data/models/user_data_model.dart';

class AuthRepos {
  final AuthApiServices authApiServices;

  AuthRepos(this.authApiServices);

  /// Login
  Future<ApiResult<UserDataModel>> login({
    required String phoneOrEmail,
    required String password,
    required bool acceptTerms,
    required String fcmToken,
  }) async {
    try {
      final response = await authApiServices.login(
        phoneOrEmail: phoneOrEmail,
        password: password,
        acceptTerms: acceptTerms,
        fcmToken: fcmToken,
      );
      if (response == null) {
        print('response is null');
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 200) {
        final userData = UserDataModel.fromJson(response.data);

        /// Save user data to shared preferences
        /// Save Id
        final userId = userData.result?.id;
        await CacheHelper.saveData(
          key: CacheKeys.userId,
          value: userId,
        );

        /// Save Token
        final userToken = userData.authorization?.token;
        await CacheHelper.saveSecuredString(
          key: CacheKeys.userToken,
          value: userToken,
        );

        /// Sve Email
        final userEmail = userData.result?.email;
        await CacheHelper.saveData(
          key: CacheKeys.userEmail,
          value: userEmail,
        );

        /// Save Name
        final userName = userData.result?.name;
        await CacheHelper.saveData(
          key: CacheKeys.userName,
          value: userName,
        );

        /// Save Phone
        final userPhone = userData.result?.phone;
        await CacheHelper.saveSecuredString(
          key: CacheKeys.userPhone,
          value: userPhone,
        );

        /// Save Image
        // final userImage = userData.result?.imageUrl;
        // await CacheHelper.saveData(
        //   key: CacheKeys.userImage,
        //   value: userImage,
        // );

        /// Save Role
        final userRole = userData.result?.role;
        await CacheHelper.saveData(
          key: CacheKeys.userRole,
          value: userRole,
        );

        /// Set token in AppConstants
        AppConstants.userToken = userToken;

        /// Debug logs
        if (kDebugMode) {
          print('✅ Token saved: $userToken');
          print('✅ User en logged in: ${userData.result?.name}');
          print('✅ User email: ${CacheHelper.getData(key: CacheKeys.userEmail)}');
          print('✅ User name: ${CacheHelper.getData(key: CacheKeys.userName)}');
          print('✅ User phone: ${CacheHelper.getData(key: CacheKeys.userPhone)}');
          print('✅ User image: ${CacheHelper.getData(key: CacheKeys.userImage)}');
        }

        /// Show success toast
        ToastManager.showCustomToast(
          message: userData.message ?? '',
          backgroundColor: AppColors.greenColor200,
          icon: Icons.check_circle_outline,
          duration: const Duration(seconds: 3),
        );

        return ApiResult.success(userData);
      }
      else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<UserDataModel>(response);
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

  /// Forget Password
  Future<ApiResult<String>> forgetPassword({required String email}) async {
    try {
      final response = await authApiServices.forgetPassword(email: email);

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200) {
        ToastManager.showCustomToast(
          message: response.data['message'],
          backgroundColor: AppColors.greenColor200,
          icon: Icons.error_outline,
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
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Confirm Email OTP
  Future<ApiResult<String>> confirmPhoneEmailOTP({
    required String phoneOrEmail,
    required String otp,
  }) async {
    try {
      final response = await authApiServices.confirmPhoneEmailOTP(
        phoneOrEmail: phoneOrEmail,
        otp: otp,
      );

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200) {
        ToastManager.showCustomToast(
          message: response.data['message'],
          backgroundColor: AppColors.greenColor200,
          icon: Icons.error_outline,
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
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Register
  Future<ApiResult<String>> register({
    required String name,
    required String email,
    required String phone,
    required bool acceptTerms,
  }) async {
    try {
      final response = await authApiServices.register(
        name: name,
        email: email,
        phone: phone,
        acceptTerms: acceptTerms,
      );

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        ToastManager.showCustomToast(
          message: response.data['message'],
          backgroundColor: AppColors.greenColor200,
          icon: Icons.error_outline,
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
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Set Password
  Future<ApiResult<String>> setPassword({
    required String phoneOrEmail,
    required String password,
    required String cPassword,
  }) async {
    try {
      final response = await authApiServices.setPassword(
        phoneOrEmail: phoneOrEmail,
        password: password,
        cPassword: cPassword,
      );

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200) {
        ToastManager.showCustomToast(
          message: response.data['message'],
          backgroundColor: AppColors.greenColor200,
          icon: Icons.error_outline,
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
    } catch (e, stackTrace) {
      print('❌ Unexpected error: $e');
      print('📌 Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}