import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/addresses/data/models/addresses_data_model.dart';
import 'package:nourex/features/cart/data/models/apply_coupon_data_model.dart';
import 'package:nourex/features/cart/data/models/cart_data_model.dart';
import 'package:nourex/features/cart/data/models/main_address_data_model.dart';
import 'package:nourex/features/cart/data/models/make_order_response_model.dart';
import 'package:nourex/features/cart/data/repos/repos.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepos) : super(CartInitial());

  final CartRepos cartRepos;

  PaymentMethod selectedMethod = PaymentMethod.cod;

  CartDataModel? cartDataModel;
  TextEditingController couponController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  AppLyCouponDataModel? appLyCouponDataModel;
  MainAddressDataModel? mainAddressDataModel;
  MakeOrderResponseModel? makeOrderResponseModel;

  String orderSeq = '';

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

  /// Apply Coupon
  Future<void> applyCoupon({
    required String cartTotal,
  }) async {
    emit(ApplyCouponLoadingState());
    showLoading();
    final result = await cartRepos.applyCoupon(
      cartTotal: cartTotal,
      couponName: couponController.text,
    );
    result.when(
      success: (data) {
        hideLoading();
        appLyCouponDataModel = data;
        emit(ApplyCouponSuccessState(
          discountName: appLyCouponDataModel!.discount.toString(),
          discountAmount: appLyCouponDataModel!.discountAmount.toString(),
          newTotal: appLyCouponDataModel!.newTotal.toString(),
        ));
      },
      failure: (error) {
        hideLoading();
        emit(ApplyCouponErrorState(error.message));
      },
    );
  }

  /// Get Main Address
  Future<void> getMainAddress() async {
    emit(GetMainAddressLoadingState());
    final result = await cartRepos.getMainAddress();
    result.when(
      success: (data) {
        mainAddressDataModel = data;
        emit(GetMainAddressSuccessState());
      },
      failure: (error) {
        emit(GetMainAddressErrorState(error.message));
      },
    );
  }

  /// Make Order
  Future<void> makeOrder({
    required String paymentMethod,
    String? coupon,
    required String address,
    String? notes,
  }) async {
    showLoading();
    emit(MakeOrderLoadingState());
    final result = await cartRepos.makeOrder(
      paymentMethod: paymentMethod,
      coupon: coupon,
      couponCode: couponController.text,
      address: address,
      notes: notesController.text,
    );
    result.when(
      success: (data) {
        makeOrderResponseModel = data;
        orderSeq = makeOrderResponseModel!.order!.orderSeq.toString();
        hideLoading();
        emit(MakeOrderSuccessState(makeOrderResponseModel: makeOrderResponseModel!));
      },
      failure: (error) {
        hideLoading();
        emit(MakeOrderErrorState(error.message));
      },
    );
  }
}
