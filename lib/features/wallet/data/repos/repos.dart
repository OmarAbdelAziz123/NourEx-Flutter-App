import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/wallet/data/api_services/api_services.dart';
import 'package:nourex/features/wallet/data/models/wallet_data_model.dart';

class WalletRepos {
  final WalletApiServices walletApiServices;

  WalletRepos(this.walletApiServices);

  /// Get Wallet History
  Future<ApiResult<WalletDataModel>> getWalletHistory({required String type}) async {
    try {
      final response = await walletApiServices.getWalletHistory(type: type);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        WalletDataModel walletDataModel = WalletDataModel.fromJson(response.data);
        return ApiResult.success(walletDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return ErrorHandler.handleValidationErrorResponse<WalletDataModel>(response);
        } else {
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

  /// Make Preview Redeem Points
  Future<ApiResult<String>> makePreviewRedeemPoints({required int requestedPoints}) async {
    try {
      final response = await walletApiServices.makePreviewRedeemPoints(requestedPoints: requestedPoints);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        return ApiResult.success(response.data['redeemedAmount'].toString());
      } else {
        if (response.data['message'] == 'Validation Error') {
          return ErrorHandler.handleValidationErrorResponse<String>(response);
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

  /// Redeem Points
  Future<ApiResult<String>> redeemPoints({required int requestedPoints}) async {
    try {
      final response = await walletApiServices.redeemPoints(requestedPoints: requestedPoints);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        return ApiResult.success(response.data['redeemedAmount'].toString());
      } else {
        if (response.data['message'] == 'Validation Error') {
          return ErrorHandler.handleValidationErrorResponse<String>(response);
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