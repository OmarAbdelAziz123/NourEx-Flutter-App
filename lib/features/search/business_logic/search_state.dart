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