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