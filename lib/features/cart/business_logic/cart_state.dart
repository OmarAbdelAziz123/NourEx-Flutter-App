part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

/// Change Payment Method
class ChangePaymentMethodState extends CartState {
  final PaymentMethod selectedMethod;

  ChangePaymentMethodState(this.selectedMethod);
}

/// Enum Payment Method
enum PaymentMethod {
  wallet,
  cod,
}

/// Add Product To Cart
class AddProductToCartLoadingState extends CartState {}

class AddProductToCartSuccessState extends CartState {}

class AddProductToCartErrorState extends CartState {
  final String error;
  AddProductToCartErrorState(this.error);
}

/// Get Cart
class GetCartLoadingState extends CartState {}

class GetCartSuccessState extends CartState {}

class GetCartErrorState extends CartState {
  final String error;
  GetCartErrorState(this.error);
}

/// Remove Product From Cart
class RemoveProductFromCartLoadingState extends CartState {}

class RemoveProductFromCartSuccessState extends CartState {}

class RemoveProductFromCartErrorState extends CartState {
  final String error;
  RemoveProductFromCartErrorState(this.error);
}

/// Update To Product In Cart
class UpdatePlusCartLoadingState extends CartState {}

class UpdatePlusCartSuccessState extends CartState {}

class UpdatePlusCartErrorState extends CartState {
  final String error;
  UpdatePlusCartErrorState(this.error);
}

/// Update To Product In Cart
class UpdateMinusCartLoadingState extends CartState {}

class UpdateMinusCartSuccessState extends CartState {}

class UpdateMinusCartErrorState extends CartState {
  final String error;
  UpdateMinusCartErrorState(this.error);
}

/// Apply Coupon
class ApplyCouponLoadingState extends CartState {}

class ApplyCouponSuccessState extends CartState {
  final String discountName;
  final String discountAmount;
  final String newTotal;

  ApplyCouponSuccessState({
    required this.discountName,
    required this.discountAmount,
    required this.newTotal,
  });
}

class ApplyCouponErrorState extends CartState {
  final String error;
  ApplyCouponErrorState(this.error);
}

/// Get Main Addresses States
class GetMainAddressLoadingState extends CartState {}

class GetMainAddressSuccessState extends CartState {}

class GetMainAddressErrorState extends CartState {
  final String error;
  GetMainAddressErrorState(this.error);
}

/// Make Order
final class MakeOrderLoadingState extends CartState {}

final class MakeOrderSuccessState extends CartState {
  final MakeOrderResponseModel makeOrderResponseModel;
  MakeOrderSuccessState({required this.makeOrderResponseModel});
}

final class MakeOrderErrorState extends CartState {
  final String error;
  MakeOrderErrorState(this.error);
}