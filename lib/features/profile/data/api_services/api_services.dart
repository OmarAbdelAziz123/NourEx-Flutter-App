import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class ProfileApiServices {
  final DioHelper _dioFactory;

  ProfileApiServices(this._dioFactory);

  /// Get Profile
  Future<Response?> getProfile() async {
    return await _dioFactory.get(endPoint: EndPoints.getProfile);
  }

  /// Update Profile
  Future<Response?> updateProfile(
    String? name,
    String? email,
    String? phone,
    String? age,
    File? profileImage,
  ) async {
    final formData = FormData();

    /// Add text fields if they are not null
    if (name != null) formData.fields.add(MapEntry('name', name));
    if (email != null) formData.fields.add(MapEntry('email', email));
    if (phone != null) formData.fields.add(MapEntry('phone', phone));
    if (age != null) formData.fields.add(MapEntry('age', age));

    /// Add file if it exists
    if (profileImage != null) {
      final fileName = profileImage.path.split('/').last;
      final mimeType = lookupMimeType(profileImage.path) ?? 'image/jpeg';
      final mediaType = MediaType.parse(mimeType);


      formData.files.add(
        MapEntry(
          'profilePic',
          await MultipartFile.fromFile(
            profileImage.path,
            filename: fileName,
            contentType: mediaType,
          ),
        ),
      );
    }

    return await _dioFactory.patch(
      endPoint: EndPoints.updateProfile,
      data: formData,
    );
  }

  /// Logout
  Future<Response?> userLogout() async {
    return await _dioFactory.patch(endPoint: EndPoints.logout);
  }
}
