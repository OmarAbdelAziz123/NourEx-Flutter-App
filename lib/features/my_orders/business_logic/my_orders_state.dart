part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

/// Change Tab State
final class ChangeTabState extends MyOrdersState {}

/// Get All Orders State
final class GetAllMyOrdersLoadingState extends MyOrdersState {}

final class GetAllMyOrdersSuccessState extends MyOrdersState {
  final List<MyOrder> myOrders;
  final bool isLastPage;

  GetAllMyOrdersSuccessState(this.myOrders, this.isLastPage);
}

final class GetAllMyOrdersErrorState extends MyOrdersState {
  final String message;

  GetAllMyOrdersErrorState(this.message);
}

final class GetAllMyOrdersPaginationLoadingState extends MyOrdersState {}

/// Make Return Order State
final class MakeReturnOrderLoadingState extends MyOrdersState {}

final class MakeReturnOrderSuccessState extends MyOrdersState {}

final class MakeReturnOrderErrorState extends MyOrdersState {
  final String message;

  MakeReturnOrderErrorState(this.message);
}

/// Make Cancel Order State
final class MakeCancelOrderLoadingState extends MyOrdersState {}

final class MakeCancelOrderSuccessState extends MyOrdersState {}

final class MakeCancelOrderErrorState extends MyOrdersState {
  final String message;

  MakeCancelOrderErrorState(this.message);
}

/// Make Delivery Order State
final class MakeDeliveryOrderLoadingState extends MyOrdersState {}

final class MakeDeliveryOrderSuccessState extends MyOrdersState {}

final class MakeDeliveryOrderErrorState extends MyOrdersState {
  final String message;

  MakeDeliveryOrderErrorState(this.message);
}