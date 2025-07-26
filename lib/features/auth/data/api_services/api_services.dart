import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class AuthApiServices {
  final DioHelper _dioFactory;

  AuthApiServices(this._dioFactory);

  /// Login
  Future<Response?> login({
    required String phoneOrEmail,
    required String password,
    required bool acceptTerms,
    required String fcmToken,
  }) async {
    return await _dioFactory.post(
      endPoint: EndPoints.login,
      data: {
        "phoneOrEmail": phoneOrEmail,
        "password": password,
        "acceptTerms": acceptTerms,
        "fcmToken": fcmToken,
      },
    );
  }

  /// Forget Password
  Future<Response?> forgetPassword({
    required String email,
  }) async {
    return await _dioFactory.post(
      endPoint: EndPoints.emailOTP,
      data: {
        "email": email,
      },
    );
  }

  /// Register
  Future<Response?> register({
    required String name,
    required String email,
    required String phone,
    required bool acceptTerms,
  }) async {
    return await _dioFactory.post(
      endPoint: EndPoints.register,
      data: {
        "name": name,
        "email": email,
        "phone": '+963$phone',
        "acceptTerms": acceptTerms,
      },
    );
  }

  /// Confirm Phone Email OTP
  Future<Response?> confirmPhoneEmailOTP({
    required String phoneOrEmail,
    required String otp,
  }) async {
    return await _dioFactory.post(
      endPoint: EndPoints.confirmPhoneEmailOTP(phoneOrEmail),
      data: {
        "otp": otp,
      },
    );
  }

  /// Set Password
  Future<Response?> setPassword({
    required String phoneOrEmail,
    required String password,
    required String cPassword,
  }) async {
    return await _dioFactory.post(
      endPoint: EndPoints.setPassword(phoneOrEmail),
      data: {
        "password": password,
        "cPassword": cPassword,
      },
    );
  }
}
