import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/data/repos/repos.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepos) : super(ProductsInitial()) {
    _initScrollListener();
    /// ✅ Add scroll listener on cubit creation
    getInitialProducts();
    /// ✅ Load initial data when cubit is created
  }

  int selectedRating = 0; /// ✅ "الكل" هو الافتراضي

  final ProductsRepos productsRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();

  List<ProductModel> allProducts = [];
  ProductModel? productModel;
  ProductDetailsModel? productDetailsModel;
  bool isFetching = false;

  /// Toggle Selected Rating
  void toggleRating(int rating) {
    selectedRating = rating;
    emit(ToggleSelectedRating(selectedRating));
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
        getMoreProducts();
      }
    });
  }

  /// Get Initial Products
  Future<void> getInitialProducts() async {
    emit(GetAllProductsLoadingState());
    currentPage = 1;
    allProducts.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await productsRepos.getAllProducts(page: currentPage);

    result.when(
      success: (data) {
        allProducts = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(
          GetAllProductsSuccessState(allProducts, currentPage >= totalPages),
        );
      },
      failure: (error) {
        emit(GetAllProductsErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreProducts() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetAllProductsPaginationLoadingState());
    currentPage++;

    final result = await productsRepos.getAllProducts(page: currentPage);

    result.when(
      success: (data) {
        allProducts.addAll(data.result ?? []);
        emit(
          GetAllProductsSuccessState(allProducts, currentPage >= totalPages),
        );
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllProductsErrorState(error.message));
      },
    );

    isFetching = false;
  }

  /// Get Products By Category
  Future<void> getInitialProductsByCategory({required String categoryId}) async {
    emit(GetProductByCategoryLoadingState());
    currentPage = 1;
    allProducts.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await productsRepos.getProductsByCategory(
      page: currentPage,
      categoryId: categoryId,
    );

    result.when(
      success: (data) {
        allProducts = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(
          GetProductByCategorySuccessState(allProducts, currentPage >= totalPages),
        );
      },
      failure: (error) {
        emit(GetProductByCategoryErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreProductsByCategory({required String categoryId}) async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetProductByCategoryPaginationLoadingState());
    currentPage++;

    final result = await productsRepos.getProductsByCategory(
      page: currentPage,
      categoryId: categoryId,
    );

    result.when(
      success: (data) {
        allProducts.addAll(data.result ?? []);
        emit(
          GetProductByCategorySuccessState(allProducts, currentPage >= totalPages),
        );
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetProductByCategoryErrorState(error.message));
      },
    );

    isFetching = false;
  }

  /// Get Product By Id
  Future<void> getProductById({required String productId}) async {
    emit(GetProductByIdLoadingState());
    final result = await productsRepos.getProductById(productId: productId);
    result.when(
      success: (data) {
        productDetailsModel = data;
        emit(GetProductByIdSuccessState(productDetailsModel!));
      },
      failure: (error) {
        emit(GetProductByIdErrorState(error.message));
      },
    );
  }

  @override
  Future<void> close() {
    /// ✅ Clean up scroll controller
    scrollController.dispose();
    return super.close();
  }
}
