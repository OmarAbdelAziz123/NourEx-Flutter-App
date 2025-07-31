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
  cashOnDelivery,
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
