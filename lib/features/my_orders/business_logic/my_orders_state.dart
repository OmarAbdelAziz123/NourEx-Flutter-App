part of 'my_orders_cubit.dart';

@immutable
sealed class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

/// Change Tab State
final class ChangeTabState extends MyOrdersState {}


