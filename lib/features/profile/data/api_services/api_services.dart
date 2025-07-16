import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class ProfileApiServices {
  final DioHelper _dioFactory;

  ProfileApiServices(this._dioFactory);

  /// Logout
  Future<Response?> userLogout() async {
    return await _dioFactory.patch(endPoint: EndPoints.logout);
  }
}