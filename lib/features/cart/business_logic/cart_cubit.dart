import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/cart/data/models/cart_data_model.dart';
import 'package:nourex/features/cart/data/repos/repos.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepos) : super(CartInitial());

  final CartRepos cartRepos;

  PaymentMethod selectedMethod = PaymentMethod.cashOnDelivery;

  CartDataModel? cartDataModel;

  /// Toggle Payment Method
  void togglePaymentMethod(PaymentMethod method) {
    selectedMethod = method;
    emit(ChangePaymentMethodState(method));
  }

  /// Add Product To Cart
  Future<void> addProductToCart({
    required String productId,
    required int quantity,
    required String variantSku,
  }) async {
    emit(AddProductToCartLoadingState());
    showLoading();

    final result = await cartRepos.addProductToCart(
      productId: productId,
      quantity: quantity,
      variantSku: variantSku,
    );
    result.when(
      success: (data) {
        hideLoading();

        emit(AddProductToCartSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(AddProductToCartErrorState(error.message));
      },
    );
  }

  /// Get Cart
  Future<void> getCart() async {
    emit(GetCartLoadingState());
    final result = await cartRepos.getCart();
    result.when(
      success: (data) {
        cartDataModel = data;
        emit(GetCartSuccessState());
      },
      failure: (error) {
        emit(GetCartErrorState(error.message));
      },
    );
  }

  /// Remove Product From Cart
  Future<void> removeProductFromCart({
    required String productId,
    required String variantSku,
  }) async {
    emit(RemoveProductFromCartLoadingState());
    showLoading();
    final result = await cartRepos.removeProductFromCart(
      productId: productId,
      variantSku: variantSku,
    );
    result.when(
      success: (data) {
        hideLoading();
        emit(RemoveProductFromCartSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(RemoveProductFromCartErrorState(error.message));
      },
    );
  }

  /// Update Cart
  Future<void> updatePlusCart({
    required String productId,
    required String variantSku,
    required int amount,
  }) async {
    emit(UpdatePlusCartLoadingState());
    showLoading();
    final result = await cartRepos.updateProductFromCart(
      productId: productId,
      variantSku: variantSku,
      amount: amount,
    );
    result.when(
      success: (data) {
        hideLoading();
        emit(UpdatePlusCartSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(UpdatePlusCartErrorState(error.message));
      },
    );
  }
}
