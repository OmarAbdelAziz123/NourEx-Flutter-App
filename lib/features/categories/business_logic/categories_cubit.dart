import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/categories/data/model/category_data_model.dart';
import 'package:nourex/features/categories/data/repos/repos.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesRepos) : super(CategoriesInitial()) {
    _initScrollListener(); /// ✅ Add scroll listener on cubit creation
    getInitialCategories(); /// ✅ Load initial data when cubit is created
  }

  final CategoriesRepos categoriesRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<CategoryModel> allCategories = [];
  bool isFetching = false;

  CategoryDataModel? categoriesDataModel;
  int selectedCategoryIndex = 0;

  /// Change Category
  void changeCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ProductsCategoryChanged(index));
  }


  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          !isFetching &&
          currentPage < totalPages) {
        getMoreCategories();
      }
    });
  }

  /// Get Initial Categories
  Future<void> getInitialCategories() async {
    emit(GetAllCategoriesLoadingState());
    currentPage = 1;
    allCategories.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await categoriesRepos.getAllCategories(page: currentPage);

    result.when(
      success: (data) {
        allCategories = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(GetAllCategoriesSuccessState(allCategories, currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetAllCategoriesErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreCategories() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(CategoriesPaginationLoading());
    currentPage++;

    final result = await categoriesRepos.getAllCategories(
      page: currentPage,
    );

    result.when(
      success: (data) {
        allCategories.addAll(data.result ?? []);
        emit(GetAllCategoriesSuccessState(allCategories, currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllCategoriesErrorState(error.message));
      },
    );

    isFetching = false;
  }

  @override
  Future<void> close() {
    scrollController.dispose(); // ✅ Clean up scroll controller
    return super.close();
  }
  // /// Init Scroll Listener
  // void _initScrollListener() {
  //   scrollController.addListener(() {
  //     final position = scrollController.position;
  //
  //     /// ✅ Trigger only near bottom & if not already loading
  //     if (position.pixels >= position.maxScrollExtent - 100 &&
  //         !isFetching &&
  //         currentPage < totalPages) {
  //       getMoreCategories();
  //     }
  //   });
  // }
  //
  // /// Get Initial Categories
  // Future<void> getInitialCategories() async {
  //   emit(GetAllCategoriesLoadingState());
  //   currentPage = 1;
  //   allCategories.clear();
  //
  //   final result = await categoriesRepos.getAllCategories(page: currentPage);
  //
  //   result.when(
  //     success: (data) {
  //       allCategories = data.result ?? [];
  //       totalPages = data.pagination?.pages ?? 1;
  //       emit(GetAllCategoriesSuccessState(allCategories, currentPage >= totalPages));
  //     },
  //     failure: (error) {
  //       emit(GetAllCategoriesErrorState(error.message));
  //     },
  //   );
  // }
  //
  // /// Fetch More for Pagination
  // Future<void> getMoreCategories() async {
  //   if (isFetching || currentPage >= totalPages) return;
  //
  //   isFetching = true;
  //   emit(CategoriesPaginationLoading());
  //   currentPage++;
  //
  //   final result = await categoriesRepos.getAllCategories(
  //     page: currentPage,
  //   );
  //
  //   result.when(
  //     success: (data) {
  //       allCategories.addAll(data.result ?? []);
  //       emit(GetAllCategoriesSuccessState(allCategories, currentPage >= totalPages));
  //     },
  //     failure: (error) {
  //       emit(GetAllCategoriesErrorState(error.message));
  //     },
  //   );
  //
  //   isFetching = false;
  // }
}
