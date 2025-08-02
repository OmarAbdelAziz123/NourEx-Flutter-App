import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/products/data/models/products_reviews_data_model.dart';
import 'package:nourex/features/products/data/models/variant_option.dart';
import 'package:nourex/features/products/data/repos/repos.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productsRepos) : super(ProductsInitial()) {
    _initScrollListener();
    getInitialProducts();
  }

  int selectedRating = 0;
  final ProductsRepos productsRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<ProductModel> allProducts = [];
  List<ProductReview> allProductReviews = [];
  ProductModel? productModel;
  ProductDetailsModel? productDetailsModel;
  bool isFetching = false;

  // ✅ Added state for product details screen
  Map<String, String?> selectedVariants = {};
  num? selectedPrice;

  /// Toggle Selected Rating
  void toggleRating(int rating) {
    selectedRating = rating;
    emit(ToggleSelectedRating(selectedRating));
  }

  /// ✅ Update Selected Variants
  void updateSelectedVariant(String variantType, String? value) {
    selectedVariants[variantType] = value;
    _updatePriceBasedOnVariant();
    emit(VariantSelectionUpdated(Map.from(selectedVariants), selectedPrice));
  }

  /// ✅ Update Main Image
  void updateMainImage(String imageUrl) {
    if (productDetailsModel?.result != null) {
      productDetailsModel!.result!.mainImageURL = imageUrl;
      emit(MainImageUpdated(imageUrl));
    }
  }

  /// ✅ Update Price Based on Selected Variants
  void _updatePriceBasedOnVariant() {
    final product = productDetailsModel?.result;
    if (product == null) return;

    for (var variant in product.variants ?? []) {
      bool isMatch = true;

      for (var attr in variant.attributes ?? []) {
        final selectedValue = selectedVariants[attr.name];
        if (selectedValue == null || selectedValue != attr.value) {
          isMatch = false;
          break;
        }
      }

      if (isMatch) {
        selectedPrice = variant.price;
        return;
      }
    }

    // Fallback to default
    // Fallback: if no matching variant found, use the first variant's price
    if (product.variants?.isNotEmpty == true) {
      final firstVariant = product.variants!.first;
      selectedPrice = firstVariant.priceAfterDiscount ?? firstVariant.price ?? 0;
    } else {
      selectedPrice = 0;
    }
  }

  /// ✅ Reset Product Details State
  void resetProductDetailsState() {
    selectedVariants.clear();
    selectedPrice = null;
  }

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

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
    isFetching = false;

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
        currentPage--;
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
    isFetching = false;

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
        currentPage--;
        emit(GetProductByCategoryErrorState(error.message));
      },
    );

    isFetching = false;
  }

  /// Get Product By Id
  Future<void> getProductById({required String productId}) async {
    emit(GetProductByIdLoadingState());
    resetProductDetailsState(); // ✅ Reset state when loading new product

    final result = await productsRepos.getProductById(productId: productId);
    result.when(
      success: (data) {
        productDetailsModel = data;
        productDetailsModel!.result!.subImages!
            .insert(0, productDetailsModel!.result!.mainImageURL!);

        /// ✅ Set initial price
        // selectedPrice = productDetailsModel!.result!.finalPrice; // ✅ Set initial price
        selectedPrice = productDetailsModel!.result!.variants?.first.priceAfterDiscount;


        /// ✅ Auto-select first variant of each type
        _selectFirstVariants();
        emit(GetProductByIdSuccessState(productDetailsModel!));
      },
      failure: (error) {
        emit(GetProductByIdErrorState(error.message));
      },
    );
  }

  /// ✅ New method to automatically select first variant of each type
  void _selectFirstVariants() {
    final product = productDetailsModel?.result;
    if (product?.variants == null || product!.variants!.isEmpty) return;

    /// Build variant map to get all variant types and their values
    final variantMap = product.addInvariantsMap();

    /// Auto-select first value for each variant type
    variantMap.forEach((variantType, values) {
      if (values.isNotEmpty && values.first != null) {
        selectedVariants[variantType] = values.first;
      }
    });

    /// Update price based on selected variants
    _updatePriceBasedOnVariant();

    /// Emit state update
    emit(VariantSelectionUpdated(Map.from(selectedVariants), selectedPrice));
  }

  Future<void> fetchVariantByAttributes(Map<String?, String?> selectedVariants) async {
    final allVariants = productDetailsModel?.result?.variants;

    if (allVariants == null || allVariants.isEmpty) {
      print('No variants available.');
      return;
    }

    for (final variant in allVariants) {
      final attributes = variant.attributes;

      if (attributes == null) continue;

      final isMatch = selectedVariants.entries.every((entry) {
        return attributes.any((attr) =>
        attr.name?.toLowerCase() == entry.key!.toLowerCase() &&
            attr.value?.toLowerCase() == entry.value!.toLowerCase());
      });

      if (isMatch) {
        productModel = ProductModel(
          id: productDetailsModel?.result?.sId,
          name: productDetailsModel?.result?.name,
          mainImageURL: productDetailsModel?.result?.mainImageURL,
          sku: variant.sku,
          createdAt: productDetailsModel?.result?.createdAt,
        );

        emit(ProductVariantSelectedState(variant));
        print('✅ Matching Variant Found: ${variant.sku}');
        return;
      }
    }

    print('❌ No matching variant found for $selectedVariants');
    emit(ProductVariantNotFoundState());
  }

  /// Get Product Reviews
  Future<void> getInitialProductReviews({required String productId}) async {
    emit(GetProductReviewsLoadingState());
    currentPage = 1;
    allProductReviews.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await productsRepos.getProductReviews(
      productId: productId,
      page: currentPage,
    );

    result.when(
      success: (data) {
        allProductReviews = data.reviews ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(GetProductReviewsSuccessState(allProductReviews, currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetProductReviewsErrorState(error.message));
      },
    );
    isFetching = false;

  }

  Future<void> getMoreProductReviews() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true; // ✅ Set fetching state
    emit(ProductReviewsPaginationLoading());
    currentPage++;

    final result = await productsRepos.getProductReviews(
      productId: productDetailsModel?.result?.sId ?? '',
      page: currentPage,
    );

    result.when(
      success: (data) {
        allProductReviews.addAll(data.reviews ?? []);
        emit(GetProductReviewsSuccessState(allProductReviews, currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetProductReviewsErrorState(error.message));
      },
    );

    isFetching = false; // ✅ Reset fetching state
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}

// class ProductsCubit extends Cubit<ProductsState> {
//   ProductsCubit(this.productsRepos) : super(ProductsInitial()) {
//     _initScrollListener();
//
//     /// ✅ Add scroll listener on cubit creation
//     getInitialProducts();
//
//     /// ✅ Load initial data when cubit is created
//   }
//
//   int selectedRating = 0;
//
//   /// ✅ "الكل" هو الافتراضي
//
//   final ProductsRepos productsRepos;
//
//   int currentPage = 1;
//   int totalPages = 1;
//   final ScrollController scrollController = ScrollController();
//
//   List<ProductModel> allProducts = [];
//   ProductModel? productModel;
//   ProductDetailsModel? productDetailsModel;
//   bool isFetching = false;
//
//   /// Toggle Selected Rating
//   void toggleRating(int rating) {
//     selectedRating = rating;
//     emit(ToggleSelectedRating(selectedRating));
//   }
//
//   /// Init Scroll Listener
//   void _initScrollListener() {
//     scrollController.addListener(() {
//       final position = scrollController.position;
//
//       /// ✅ Only trigger when user scrolls down
//       if (position.userScrollDirection == ScrollDirection.reverse &&
//           position.pixels >= position.maxScrollExtent - 100 &&
//           !isFetching &&
//           currentPage < totalPages) {
//         getMoreProducts();
//       }
//     });
//   }
//
//   /// Get Initial Products
//   Future<void> getInitialProducts() async {
//     emit(GetAllProductsLoadingState());
//     currentPage = 1;
//     allProducts.clear();
//     isFetching = false; // ✅ Reset fetching state
//
//     final result = await productsRepos.getAllProducts(page: currentPage);
//
//     result.when(
//       success: (data) {
//         allProducts = data.result ?? [];
//         totalPages = data.pagination?.pages ?? 1;
//         emit(
//           GetAllProductsSuccessState(allProducts, currentPage >= totalPages),
//         );
//       },
//       failure: (error) {
//         emit(GetAllProductsErrorState(error.message));
//       },
//     );
//   }
//
//   /// Fetch More for Pagination
//   Future<void> getMoreProducts() async {
//     if (isFetching || currentPage >= totalPages) return;
//
//     isFetching = true;
//     emit(GetAllProductsPaginationLoadingState());
//     currentPage++;
//
//     final result = await productsRepos.getAllProducts(page: currentPage);
//
//     result.when(
//       success: (data) {
//         allProducts.addAll(data.result ?? []);
//         emit(
//           GetAllProductsSuccessState(allProducts, currentPage >= totalPages),
//         );
//       },
//       failure: (error) {
//         currentPage--; // ✅ Revert page increment on error
//         emit(GetAllProductsErrorState(error.message));
//       },
//     );
//
//     isFetching = false;
//   }
//
//   /// Get Products By Category
//   Future<void> getInitialProductsByCategory(
//       {required String categoryId}) async {
//     emit(GetProductByCategoryLoadingState());
//     currentPage = 1;
//     allProducts.clear();
//     isFetching = false; // ✅ Reset fetching state
//
//     final result = await productsRepos.getProductsByCategory(
//       page: currentPage,
//       categoryId: categoryId,
//     );
//
//     result.when(
//       success: (data) {
//         allProducts = data.result ?? [];
//         totalPages = data.pagination?.pages ?? 1;
//         emit(
//           GetProductByCategorySuccessState(
//               allProducts, currentPage >= totalPages),
//         );
//       },
//       failure: (error) {
//         emit(GetProductByCategoryErrorState(error.message));
//       },
//     );
//   }
//
//   /// Fetch More for Pagination
//   Future<void> getMoreProductsByCategory({required String categoryId}) async {
//     if (isFetching || currentPage >= totalPages) return;
//
//     isFetching = true;
//     emit(GetProductByCategoryPaginationLoadingState());
//     currentPage++;
//
//     final result = await productsRepos.getProductsByCategory(
//       page: currentPage,
//       categoryId: categoryId,
//     );
//
//     result.when(
//       success: (data) {
//         allProducts.addAll(data.result ?? []);
//         emit(
//           GetProductByCategorySuccessState(
//               allProducts, currentPage >= totalPages),
//         );
//       },
//       failure: (error) {
//         currentPage--; // ✅ Revert page increment on error
//         emit(GetProductByCategoryErrorState(error.message));
//       },
//     );
//
//     isFetching = false;
//   }
//
//   /// Get Product By Id
//   Future<void> getProductById({required String productId}) async {
//     emit(GetProductByIdLoadingState());
//     final result = await productsRepos.getProductById(productId: productId);
//     result.when(
//       success: (data) {
//         productDetailsModel = data;
//         productDetailsModel!.result!.subImages!
//             .insert(0, productDetailsModel!.result!.mainImageURL!);
//         emit(GetProductByIdSuccessState(productDetailsModel!));
//       },
//       failure: (error) {
//         emit(GetProductByIdErrorState(error.message));
//       },
//     );
//   }
//
//   Future<void> fetchVariantByAttributes(
//       Map<String?, String?> selectedVariants) async {
//     final allVariants = productDetailsModel?.result?.variants;
//
//     if (allVariants == null || allVariants.isEmpty) {
//       print('No variants available.');
//       return;
//     }
//
//     for (final variant in allVariants) {
//       final attributes = variant.attributes;
//
//       if (attributes == null) continue;
//
//       // Check if this variant matches all selected attributes
//       final isMatch = selectedVariants.entries.every((entry) {
//         return attributes.any((attr) =>
//             attr.name?.toLowerCase() == entry.key!.toLowerCase() &&
//             attr.value?.toLowerCase() == entry.value!.toLowerCase());
//       });
//
//       if (isMatch) {
//         productModel = ProductModel(
//           id: productDetailsModel?.result?.sId,
//           name: productDetailsModel?.result?.name,
//           price: productDetailsModel?.result?.price?.toDouble(),
//           stock: productDetailsModel?.result?.stock,
//           mainImageURL: productDetailsModel?.result?.mainImageURL,
//           discount: productDetailsModel?.result?.discount?.toDouble(),
//           finalPrice: productDetailsModel?.result?.finalPrice?.toDouble(),
//           sku: variant.sku,
//           createdAt: productDetailsModel?.result?.createdAt,
//         );
//
//         emit(ProductVariantSelectedState(variant));
//         print('✅ Matching Variant Found: ${variant.sku}');
//         return;
//       }
//     }
//
//     print('❌ No matching variant found for $selectedVariants');
//     emit(ProductVariantNotFoundState());
//   }
//
//   @override
//   Future<void> close() {
//     /// ✅ Clean up scroll controller
//     scrollController.dispose();
//     return super.close();
//   }
// }
