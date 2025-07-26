import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class AddressesApiServices {
  final DioHelper _dioFactory;

  AddressesApiServices(this._dioFactory);

  /// Add Address
  Future<Response?> addAddress({
    required String name,
    required String phoneNo,
    required String city,
    required String zone,
    required String street,
    required String type,
    required String notes,
  }) async {
    return await _dioFactory.post(endPoint: EndPoints.addAddress, data: {
      "name": name,
      "phoneNo": phoneNo,
      "city": city,
      "zone": zone,
      "street": street,
      "type": type,
      "notes": notes
    });
  }

  /// Update Address
  Future<Response?> updateAddress({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    return await _dioFactory.patch(
      endPoint: '${EndPoints.updateAddress}/$id',
      data: data,
    );
  }

  // Future<Response?> updateAddress({
  //   String? id,
  //   String? name,
  //   String? phoneNo,
  //   String? city,
  //   String? zone,
  //   String? street,
  //   String? type,
  //   String? notes,
  // }) async {
  //   final Map<String, dynamic> data = {
  //     if (name != null) "name": name,
  //     if (phoneNo != null) "phoneNo": phoneNo,
  //     if (city != null) "city": city,
  //     if (zone != null) "zone": zone,
  //     if (street != null) "street": street,
  //     if (type != null) "type": type,
  //     if (notes != null) "notes": notes,
  //   };
  //
  //   return await _dioFactory.patch(
  //     endPoint: '${EndPoints.updateAddress}/$id',
  //     data: data,
  //   );
  // }


  /// Delete Address
  Future<Response?> deleteAddress({required String id}) async {
    return await _dioFactory.delete(endPoint: '${EndPoints.deleteAddress}/$id');
  }

  /// Get All Addresses
  Future<Response?> getAllAddresses({required int page}) async {
    return await _dioFactory.get(
      endPoint: '${EndPoints.getAllAddresses}?page=$page',
    );
  }
}
