import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class SupportApiServices {
  final DioHelper _dioFactory;

  SupportApiServices(this._dioFactory);

  /// Get All Support Data
  Future<Response?> getAllSupportData(
      {required int page, required String status}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.getAllSupportData}?page=$page&status=$status');
  }

  /// Make Support Ticket
  Future<Response?> makeSupportTicket({
    required String subject,
    required String content,
  }) async {
    return await _dioFactory.post(endPoint: EndPoints.makeSupportTicket, data: {
      "subject": subject,
      "messageType": 'text',
      "content": content,
    });
  }

  /// Get Ticket Details
  Future<Response?> getTicketDetails({required String id}) async {
    return await _dioFactory.get(endPoint: '${EndPoints.getTicketDetails}/$id');
  }

  /// Send Message
  Future<Response?> sendMessage({
    required String id,
    required String messageType,
    String? content,
    XFile? supportImages,
  }) async {
    try {
      // Initialize FormData
      FormData formData = FormData();

      // Add messageType to FormData
      formData.fields.add(MapEntry('messageType', messageType));

      // Add content to FormData if provided and not empty
      if (content != null && content.isNotEmpty) {
        formData.fields.add(MapEntry('content', content));
      }

      // Add supportImages to FormData if provided
      if (supportImages != null) {
        // Get MIME type of the image
        final mimeType = lookupMimeType(supportImages.path) ?? 'application/octet-stream';

        // Add image as MultipartFile
        formData.files.add(MapEntry(
          'supportImages',
          await MultipartFile.fromFile(
            supportImages.path,
            filename: supportImages.name,
            contentType: MediaType.parse(mimeType),
          ),
        ));
      }

      // Make API request
      return await _dioFactory.post(
        endPoint: '${EndPoints.sendMessage}/$id',
        data: formData,
      );
    } catch (e) {
      print('Error sending message: $e');
      return null;
    }
  }

  /// Complete Ticket
  Future<Response?> completeTicket({required String id}) async {
    return await _dioFactory.patch(endPoint: '${EndPoints.completeTicket}/$id');
  }
}
