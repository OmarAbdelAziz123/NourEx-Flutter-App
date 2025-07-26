import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/extensions/log_util.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/networks_helper/errors/failure.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class ErrorHandler {
  final String message;

  ErrorHandler._(this.message);

  static ErrorHandler custom({required String message}) {
    return ErrorHandler._(message);
  }

  /// Handles API errors from the server
  // static FailureException handleApiError(Response? response) {
  //   String message = "error.unknown".tr();
  //
  //   if (response == null) {
  //     message = "error.noResponse".tr();
  //   } else if (response.statusCode == 401) {
  //     _navigateToUnAuthScreen();
  //     message = "error.sessionExpired".tr();
  //   } else if (response.statusCode! >= 500) {
  //     _navigateToServerErrorScreen();
  //     message = "error.serverError".tr();
  //   } else if (response.data != null && response.data is Map<String, dynamic>) {
  //     if (response.data['message'] == "error.wrongVerification" && response.data['errors'] is Map<String, dynamic>) {
  //       message = _mapValidationErrors(response.data['errors']);
  //     } else {
  //       message = response.data['message'] ?? "error.unexpected".tr();
  //     }
  //   } else {
  //     message = "error.unexpectedResponse".tr();
  //   }
  //
  //   _showToast(message, isError: true);
  //   return FailureException(errMessage: message);
  // }

  static FailureException handleApiError(dynamic response) {
    try {
      if (response?.data != null &&
          response.data['message'] == 'Validation Error' &&
          response.data['errors'] != null) {
        final errors = response.data['errors'] as Map<String, dynamic>;
        final errorMessages = errors.values.map((e) {
          if (e is List) {
            return e.join('\n');
          }
          return e.toString();
        }).join('\n');

        return FailureException(errMessage: errorMessages);
      }

      // fallback for other errors
      return FailureException(errMessage: response?.data['message'] ?? 'حدث خطأ ما');
    } catch (e) {
      return FailureException(errMessage: 'حدث خطأ غير متوقع');
    }
  }

  // static FailureException handleApiError(Response? response) {
  //   String message = "error.unknown".tr();
  //
  //   if (response == null) {
  //     message = "error.noResponse".tr();
  //   } else if (response.statusCode == 401) {
  //     // _navigateToUnAuthScreen();
  //     message = "error.sessionExpired".tr();
  //   } else if (response.statusCode! >= 500) {
  //     // _navigateToServerErrorScreen();
  //     message = "error.serverError".tr();
  //   } else if (response.data != null && response.data is Map<String, dynamic>) {
  //     final responseMessage = response.data['message'];
  //     final errors = response.data['errors'];
  //
  //     if (responseMessage == "error.wrongVerification".tr() && errors is Map<String, dynamic>) {
  //       message = _mapValidationErrors(errors);
  //     } else {
  //       message = responseMessage ?? "error.unexpected".tr();
  //     }
  //   } else {
  //     message = "error.unexpectedResponse".tr();
  //   }
  //
  //   _showToast(message, isError: true);
  //   return FailureException(errMessage: message);
  // }

  static Future<ApiResult<T>> handleValidationErrorResponse<T>(dynamic response) async {
    try {
      final Map<String, dynamic> errors = response.data['errors'];

      errors.forEach((key, value) {
        final message = (value is List) ? value.join('\n') : value.toString();
        ToastManager.showCustomToast(
          message: message,
          backgroundColor: AppColors.redColor200,
          icon: Icons.error_outline,
          duration: const Duration(seconds: 3),
        );
      });

      logError('Validation Errors: ${errors.toString()}');
      return ApiResult.failure(handleApiError(response));
    } catch (e) {
      return ApiResult.failure(FailureException(errMessage: 'حدث خطأ أثناء معالجة الاستجابة'));
    }
  }


  /// Maps validation errors into a readable string
  static String _mapValidationErrors(Map<String, dynamic> errors) {
    return errors.values.map((value) => "- $value").join("\n");
  }


  /// Handles all Dio-related errors
  static FailureException handleDioError(DioException e) {
    String errorMessage;

    switch (e.type) {
      case DioExceptionType.connectionError:
        errorMessage = "error.noConnection".tr();
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "error.requestTimeout".tr();
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "error.serverTimeout".tr();
        break;
      case DioExceptionType.badResponse:
        return handleApiError(e.response);
      case DioExceptionType.cancel:
        errorMessage = "error.requestCancelled".tr();
        break;
      case DioExceptionType.unknown:
        errorMessage = "error.network".tr();
        break;
      default:
        errorMessage = "error.connection".tr();
    }

    _showToast(errorMessage, isError: true);
    return FailureException(errMessage: errorMessage);
  }

  /// Handles unexpected errors (null values, logic errors, etc.)
  static FailureException handleUnexpectedError(Object e) {
    String errorMessage = "${'error.unexpectedError'.tr()}${e.toString()}";
    _showToast(errorMessage, isError: true);
    return FailureException(errMessage: errorMessage);
  }

  /// Shows toast messages
  static void _showToast(String message, {bool isError = false}) {
    ToastManager.showCustomToast(
      message: message,
      backgroundColor: isError ? AppColors.redColor200 : AppColors.greenColor200,
      icon: isError ? Icons.error_outline : Icons.check_circle_outline,
      duration: const Duration(seconds: 3),
    );
  }

  /// Navigate to Unauthorized Screen when status is 401
  // static void _navigateToUnAuthScreen() {
  //   final context = AppConstants.navigatorKey.currentState?.context;
  //   if (context != null) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => UnauthorizedScreen()),
  //           (route) => false,
  //     );
  //   }
  // }

  /// Navigate to Server Error Screen when status is 500
  // static void _navigateToServerErrorScreen() {
  //   final context = AppConstants.navigatorKey.currentState?.context;
  //   if (context != null) {
  //     Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => ServerErrorScreen()), // Navigate to Server Error Screen
  //           (route) => false,
  //     );
  //   }
  // }
}



