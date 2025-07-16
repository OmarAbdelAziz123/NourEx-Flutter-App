part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

/// Toggle Selected Rating
class ToggleSelectedRating extends ProductsState {
  final int selectedRating;
  ToggleSelectedRating(this.selectedRating);
}