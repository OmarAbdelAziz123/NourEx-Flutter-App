import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  PaymentMethod selectedMethod = PaymentMethod.cashOnDelivery;

  /// Toggle Payment Method
  void togglePaymentMethod(PaymentMethod method) {
    selectedMethod = method;
    emit(ChangePaymentMethodState(method));
  }
}
