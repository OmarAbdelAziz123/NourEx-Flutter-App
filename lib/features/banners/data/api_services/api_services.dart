import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class BannersApiServices {
  final DioHelper _dioHelper;

  BannersApiServices(this._dioHelper);

  /// Get All Banners
  Future<Response?> getAllBanners({required int page}) async {
    return await _dioHelper.get(endPoint: '${EndPoints.getAllBanners}?page=$page');
  }
}