import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/networks_helper/api_results/api_result.dart';
import 'package:nourex/core/networks_helper/errors/error_handler.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/features/support/data/api_services/api_services.dart';
import 'package:nourex/features/support/data/models/get_all_support_ticket_data_model.dart';
import 'package:nourex/features/support/data/models/get_ticket_details_data_model.dart';
import 'package:nourex/features/support/data/models/make_support_response_data_model.dart';

class SupportRepos {
  final SupportApiServices supportApiServices;

  SupportRepos(this.supportApiServices);

  /// Get All Support Data
  Future<ApiResult<GetAllSupportTicketDataModel>> getAllSupportData({
    required int page,
    required String status,
  }) async {
    try {
      final response = await supportApiServices.getAllSupportData(
        page: page,
        status: status,
      );

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        GetAllSupportTicketDataModel getAllSupportTicketDataModel =
            GetAllSupportTicketDataModel.fromJson(response.data);
        return ApiResult.success(getAllSupportTicketDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              GetAllSupportTicketDataModel>(response);
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

  /// Make Support Ticket
  Future<ApiResult<SupportResponseModel>> makeSupportTicket({
    required String subject,
    required String content,
  }) async {
    try {
      final response = await supportApiServices.makeSupportTicket(
        subject: subject,
        content: content,
      );

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        SupportResponseModel supportTicketModel =
            SupportResponseModel.fromJson(response.data);
        return ApiResult.success(supportTicketModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              SupportResponseModel>(response);
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

  /// Get Ticket Details
  Future<ApiResult<GetTicketDetailsDataModel>> getTicketDetails(
      {required String id}) async {
    try {
      final response = await supportApiServices.getTicketDetails(id: id);

      if (response == null) {
        return ApiResult.failure(ErrorHandler.handleApiError(null));
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        GetTicketDetailsDataModel getTicketDetailsDataModel =
            GetTicketDetailsDataModel.fromJson(response.data);
        return ApiResult.success(getTicketDetailsDataModel);
      } else {
        if (response.data['message'] == 'Validation Error') {
          return await ErrorHandler.handleValidationErrorResponse<
              GetTicketDetailsDataModel>(response);
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

  /// Send Message
  Future<ApiResult<String>> sendMessage({
    required String id,
    String? content,
    required String messageType,
    XFile? supportImages,
  }) async {
    try {
      final response = await supportApiServices.sendMessage(
        id: id,
        content: content,
        messageType: messageType,
        supportImages: supportImages,
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
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }

  /// Complete Ticket
  Future<ApiResult<String>> completeTicket({required String id}) async {
    try {
      final response = await supportApiServices.completeTicket(id: id);

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
      return ApiResult.failure(ErrorHandler.handleDioError(e));
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handleUnexpectedError(e));
    }
  }
}
