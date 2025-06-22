import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/networks_helper/errors/error_model.dart';
import 'package:nourex/core/utils/app_constants.dart';

class ToastManager {
  // static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static OverlayEntry? _overlayEntry;

  static void showCustomToast({
    required String message,
    Color backgroundColor = Colors.red,
    IconData icon = Icons.error_outline,
    Duration duration = const Duration(seconds: 3),
  }) {
    // Get the OverlayState from navigatorKey
    final overlayState = AppConstants.navigatorKey.currentState?.overlay;

    if (overlayState == null) {
      print("Error: OverlayState is null. Make sure navigatorKey is set.");
      return;
    }

    // Remove existing toast if any
    _overlayEntry?.remove();
    _overlayEntry = null;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.h,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6.r,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: Colors.white, size: 22.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlayState.insert(_overlayEntry!);

    // Remove toast after duration
    Future.delayed(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException(this.errorModel);

  factory ServerException.fromResponse(int? statusCode, dynamic response,
      {String? message}) {
    print("Raw response: $response");

    // Check if response is a Dio Response object
    final data = response is Response ? response.data : response;

    // Ensure data is a Map
    final Map<String, dynamic>? errorData = data is String
        ? jsonDecode(data) // Decode if response is a JSON string
        : data is Map<String, dynamic>
            ? data
            : null;

    print("Parsed errorData: $errorData");

    // Extract only the "message" field
    final String errorMessage = errorData?["error"]?.toString() ??
        message ??
        'An unexpected error occurred';

    print("Extracted errorMessage: $errorMessage");

    final errorModel = ErrorModel(
      status: errorData?["status"] ?? 'Unknown',
      errorMessage: errorMessage,
      code: errorData?["code"] ?? statusCode ?? 0,
    );

    // Show toast message with the extracted error message
    ToastManager.showCustomToast(
      message: errorModel.errorMessage,
    );
    // customToast(
    //   msg: errorMessage, // Displaying only the "message" field
    //   color: Colors.red,
    // );
    // customToast2(msg: errorModel.errorMessage, color: Colors.red);

    return ServerException(errorModel);
  }
}

// class ServerException implements Exception {
//   final ErrorModel errorModel;
//
//   ServerException(this.errorModel);
//
//   factory ServerException.fromResponse(int? statusCode, dynamic response, {String? message}) {
//     final Map<String, dynamic>? errorData = response is Map<String, dynamic> ? response : null;
//
//     // Extract only the "message" field if it exists
//     final String errorMessage = errorData?["message"]?.toString() ?? message ?? 'An unexpected error occurred';
//
//     final errorModel = ErrorModel(
//       status: errorData?["status"] ?? 'Unknown',
//       errorMessage: errorMessage,  // Only showing the message key
//       code: errorData?["code"] ?? statusCode ?? 0,
//     );
//
//     // Show toast message with the extracted error message
//     customToast(
//       msg: errorMessage, // Displaying only the "message" field
//       color: Colors.red,
//     );
//
//     return ServerException(errorModel);
//   }
// }

//!CacheException
class CacheException implements Exception {
  final String errorMessage;

  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CoefficientException extends ServerException {
  CoefficientException(super.errorModel);
}

class ValidationErrorException extends ServerException {
  ValidationErrorException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw BadCertificateException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request

          throw BadResponseException(ErrorModel.fromJson(e.response!.data));

        case 401: //unauthorized
          throw UnauthorizedException(ErrorModel.fromJson(e.response!.data));

        case 403: //forbidden
          throw ForbiddenException(ErrorModel.fromJson(e.response!.data));

        case 404: //not found
          throw NotFoundException(ErrorModel.fromJson(e.response!.data));

        case 409: //coefficient

          throw CoefficientException(ErrorModel.fromJson(e.response!.data));

        case 422:
          throw ValidationErrorException(ErrorModel.fromJson(e.response!.data));

        case 504: // Bad request

          throw BadResponseException(
            ErrorModel(
                status: '504', errorMessage: e.response!.data, code: 504),
          );
      }

    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: e.toString(), status: '500', code: 500),
      );

    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(errorMessage: e.toString(), status: '500', code: 500),
      );
  }
}
