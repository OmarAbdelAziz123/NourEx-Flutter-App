import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class CategoriesApiServices {
  final DioHelper _dioFactory;

  CategoriesApiServices(this._dioFactory);

  /// Get All Categories
  Future<Response?> getAllCategories({required int page}) async {
    return await _dioFactory.get(endPoint: '${EndPoints.categories}?page=$page');
  }
}