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
    double? maxRate,
  }) async {
    final queryParameters = {
      'page': page.toString(),
      'keyword': search,
      if (maxRate != null) 'maxRate': maxRate.toString(),
    };
    final uri = Uri.parse(EndPoints.search).replace(queryParameters: queryParameters);

    return await _dioFactory.get(
      endPoint: uri.toString(),
    );
  }
}
