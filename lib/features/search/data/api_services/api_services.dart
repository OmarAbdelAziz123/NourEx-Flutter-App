import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class SearchApiServices {
  final DioHelper _dioFactory;

  SearchApiServices(this._dioFactory);

  /// Get Products By Search
  Future<Response?> getProductsBySearch({
    required String search,
    required int page,
  }) async {
    return await _dioFactory.get(
      endPoint: '${EndPoints.search}?page=$page&keyword=$search',
    );
  }
}
