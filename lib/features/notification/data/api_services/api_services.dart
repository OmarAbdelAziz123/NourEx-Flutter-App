import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class NotificationApiServices {
  final DioHelper _dioFactory;

  NotificationApiServices(this._dioFactory);

  /// Get All Notifications
  Future<Response?> getAllNotifications({required int page}) async {
    return await _dioFactory.get(
      endPoint: '${EndPoints.getAllNotifications}?page=$page',
    );
  }

  
}