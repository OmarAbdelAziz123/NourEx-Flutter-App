import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();
  TextEditingController priceRangeFromController = TextEditingController();
  TextEditingController priceRangeToController = TextEditingController();
  int selectedRating = 1;

  /// On Change Search Text
  void onChangeSearchText(String searchText) {
    emit(OnChangeSearchText(searchText: searchText));
  }

  /// Toggle Selected Rating
  void toggleRating(int rating) {
    selectedRating = rating;
    emit(ToggleSelectedRating(selectedRating));
  }
}
