import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class MyOrdersApiServices {
  final DioHelper _dioFactory;

  MyOrdersApiServices(this._dioFactory);

  /// Get All My Orders
  Future<Response?> getAllMyOrders({required String status, required int page}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.getAllMyOrders}?status=$status&page=$page',);
  }
}
