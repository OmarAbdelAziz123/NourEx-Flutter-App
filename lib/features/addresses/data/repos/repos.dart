import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/addresses/data/api_services/api_services.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';

class AddressesRepos {
  final AddressesApiServices addressesApiServices;

  AddressesRepos(this.addressesApiServices);

  /// Add Address
  Future<ApiResult<String>> addAddress({
    required String name,
    required String phoneNo,
    required String city,
    required String zone,
    required String street,
    required String type,
    required String notes,
  }) async {
    try {
      final response = await addressesApiServices.addAddress(
        name: name,
        phoneNo: phoneNo,
        city: city,
        zone: zone,
        street: street,
        type: type,
        notes: notes,
      );
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
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

  /// Update Address
  Future<ApiResult<String>> updateAddress({required String id, required Map<String, dynamic> data}) async {
    try {
      final response = await addressesApiServices.updateAddress(id: id, data: data);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
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
  // Future<ApiResult<String>> updateAddress({
  //   required String id,
  //   required String name,
  //   required String phoneNo,
  //   required String city,
  //   required String zone,
  //   required String street,
  //   required String type,
  //   required String notes,
  // }) async {
  //   try {
  //     final response = await addressesApiServices.updateAddress(
  //       id: id,
  //       name: name,
  //       phoneNo: phoneNo,
  //       city: city,
  //       zone: zone,
  //       street: street,
  //       type: type,
  //       notes: notes,
  //     );
  //     if (response == null) {
  //       return ApiResult.failure(ErrorHandler.handleApiError(null));
  //     }
  //     if (response.statusCode == 200) {
  //       return ApiResult.success(response.data['message']);
  //     } else {
  //       if (response.data['message'] == 'Validation Error') {
  //         return await ErrorHandler.handleValidationErrorResponse<String>(
  //           response,
  //         );
  //       } else {
  //         ToastManager.showCustomToast(
  //           message: response.data['message'],
  //           backgroundColor: AppColors.redColor200,
  //           icon: Icons.error_outline,
  //           duration: const Duration(seconds: 3),
  //         );
  //         return ApiResult.failure(ErrorHandler.handleApiError(response));
  //       }
  //     }
  //   } on DioException catch (e) {
  //     return ApiResult.failure(ErrorHandler.handleDioError(e));
  //   } catch (e, stackTrace) {
  //     print('❌ Unexpected error: $e');
  //     print('📌 Stack trace: $stackTrace');
  //     return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
  //   }
  // }

  /// Delete Address
  Future<ApiResult<String>> deleteAddress({required String id}) async {
    try {
      final response = await addressesApiServices.deleteAddress(id: id);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        return ApiResult.success(response.data['message']);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<String>(
            response,
          );
        } else {
          print('Error in deleteAddress 22: ${response.data['message']}');
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

  /// Get All Addresses
  Future<ApiResult<AddressesDataModel>> getAllAddresses({
    required int page,
  }) async {
    try {
      final response = await addressesApiServices.getAllAddresses(page: page);
      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }
      if (response.statusCode == 200) {
        final data = AddressesDataModel.fromJson(response.data);
        return ApiResult.success(data);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
            AddressesDataModel
          >(response);
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
