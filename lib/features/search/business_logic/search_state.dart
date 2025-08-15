part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

/// On Change Search Text
class OnChangeSearchText extends SearchState {
  final String searchText;

  OnChangeSearchText({required this.searchText});
}

/// Toggle Selected Rating
class ToggleSelectedRating extends SearchState {
  final int selectedRating;

  ToggleSelectedRating(this.selectedRating);
}

/// Get Products By Search
class GetProductsBySearchLoadingState extends SearchState {}

class GetProductsBySearchSuccessState extends SearchState {
  final List<ProductModel> products;
  final bool isLastPage;

  GetProductsBySearchSuccessState({
    required this.products,
    required this.isLastPage,
  });
}

class GetProductsBySearchErrorState extends SearchState {
  final String message;

  GetProductsBySearchErrorState({required this.message});
}

final class GetProductsBySearchPaginationLoadingState extends SearchState {}