import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/features/search/data/repos/repos.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepos) : super(SearchInitial()) {
    _initScrollListener();
  }

  final SearchRepos searchRepos;

  TextEditingController searchController = TextEditingController();
  TextEditingController priceRangeFromController = TextEditingController();
  TextEditingController priceRangeToController = TextEditingController();
  int selectedRating = 1;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<ProductModel> allProducts = [];
  ProductModel? productModel;
  bool isFetching = false;

  /// On Change Search Text
  void onChangeSearchText(String searchText) {
    searchController.text = searchText;
    allProducts.clear();
    emit(OnChangeSearchText(searchText: searchText));
  }

  /// Toggle Selected Rating
  void toggleRating(int rating) {
    selectedRating = rating;
    emit(ToggleSelectedRating(selectedRating));
  }

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          !isFetching &&
          currentPage < totalPages) {
        getMoreProductsProductsBySearch();
      }
    });
  }

  /// Get Initial Products By Search
  Future<void> getInitialProductsBySearch() async {
    emit(GetProductsBySearchLoadingState());
    currentPage = 1;
    allProducts.clear();
    isFetching = false;

    final result = await searchRepos.getProductsBySearch(
        page: currentPage, search: searchController.text);

    result.when(
      success: (data) {
        allProducts = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(
          GetProductsBySearchSuccessState(
              products: allProducts, isLastPage: currentPage >= totalPages),
        );
      },
      failure: (error) {
        emit(GetProductsBySearchErrorState(message: error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreProductsProductsBySearch() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetProductsBySearchPaginationLoadingState());
    currentPage++;

    final result = await searchRepos.getProductsBySearch(
        page: currentPage, search: searchController.text);

    result.when(
      success: (data) {
        allProducts.addAll(data.result ?? []);
        emit(
          GetProductsBySearchSuccessState(
              products: allProducts, isLastPage: currentPage >= totalPages),
        );
      },
      failure: (error) {
        currentPage--;
        emit(GetProductsBySearchErrorState(message: error.message));
      },
    );

    isFetching = false;
  }
}
