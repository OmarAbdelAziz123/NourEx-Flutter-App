import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class MyOrdersApiServices {
  final DioHelper _dioFactory;

  MyOrdersApiServices(this._dioFactory);

  /// Get All My Orders
  Future<Response?> getAllMyOrders(
      {required String status, required int page}) async {
    return await _dioFactory.get(
      endPoint: '${EndPoints.getAllMyOrders}?status=$status&page=$page',
    );
  }

  /// Make Return Order
  Future<Response?> makeReturnOrder({
    required String orderId,
    required List<Map<String, String>> products,
    required List<XFile> returnImages,
    required String reason,
  }) async {
    FormData formData = FormData();

    // Add products data
    for (int i = 0; i < products.length; i++) {
      formData.fields.add(MapEntry('products[$i][productId]', products[i]['productId'] ?? ''));
      formData.fields.add(MapEntry('products[$i][variantSku]', products[i]['variantSku'] ?? ''));
    }

    // Add reason
    formData.fields.add(MapEntry('reason', reason));

    // Add return images with proper MIME type
    for (int i = 0; i < returnImages.length; i++) {
      String fileName = returnImages[i].path.split('/').last;

      // Get the proper MIME type based on file extension
      String? mimeType = lookupMimeType(returnImages[i].path);

      // Fallback to image/jpeg if MIME type cannot be determined
      mimeType ??= 'image/jpeg';

      formData.files.add(MapEntry(
        'returnImages',
        await MultipartFile.fromFile(
          returnImages[i].path,
          filename: fileName,
          contentType: MediaType.parse(mimeType), // Specify the correct MIME type
        ),
      ));
    }

    return await _dioFactory.post(
      endPoint: EndPoints.makeReturnOrder(orderId),
      data: formData,
    );
  }

  /// Make Cancel Order
  Future<Response?> makeCancelOrder({required String orderId}) async {
    return await _dioFactory.patch(
      endPoint: EndPoints.makeCancelOrder(orderId),
    );
  }

  /// Make Delivery Order
  Future<Response?> makeDeliveryOrder({required String orderId}) async {
    return await _dioFactory.patch(
      endPoint: EndPoints.makeDeliveryOrder(orderId),
    );
  }
}
