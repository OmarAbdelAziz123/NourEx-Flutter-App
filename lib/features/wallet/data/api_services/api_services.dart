import 'package:dio/dio.dart';
import 'package:nourex/core/networks_helper/dio_helper/dio_helper.dart';
import 'package:nourex/core/utils/end_points.dart';

class WalletApiServices {
  final DioHelper _dioFactory;

  WalletApiServices(this._dioFactory);

  /// Get Wallet History
  Future<Response?> getWalletHistory({required String type}) async {
    return await _dioFactory.get(
        endPoint: '${EndPoints.getWalletHistory}?type=$type');
  }

  /// Make Preview Redeem Points
  Future<Response?> makePreviewRedeemPoints({required int requestedPoints}) async {
    return await _dioFactory.post(
        endPoint: EndPoints.makePreviewRedeemPoints,
      data: {
        "pointsToRedeem": requestedPoints,
      }
    );
  }

  /// Redeem Points
  Future<Response?> redeemPoints({required int requestedPoints}) async {
    return await _dioFactory.post(
        endPoint: EndPoints.redeemPoints,
      data: {
        "pointsToRedeem": requestedPoints,
      }
    );
  }
}