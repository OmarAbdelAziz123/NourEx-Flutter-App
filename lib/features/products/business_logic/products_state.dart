part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

/// Toggle Selected Rating
class ToggleSelectedRating extends ProductsState {
  final int selectedRating;
  ToggleSelectedRating(this.selectedRating);
}

/// Get All Products
class GetAllProductsLoadingState extends ProductsState {}

class GetAllProductsSuccessState extends ProductsState {
  final List<ProductModel> products;
  final bool isLastPage;

  GetAllProductsSuccessState(this.products, this.isLastPage);
}

class GetAllProductsErrorState extends ProductsState {
  final String message;
  GetAllProductsErrorState(this.message);
}

final class GetAllProductsPaginationLoadingState extends ProductsState {}

/// Get Product By Category
class GetProductByCategoryLoadingState extends ProductsState {}

class GetProductByCategorySuccessState extends ProductsState {
  final List<ProductModel> products;
  final bool isLastPage;

  GetProductByCategorySuccessState(this.products, this.isLastPage);
}

class GetProductByCategoryErrorState extends ProductsState {
  final String message;
  GetProductByCategoryErrorState(this.message);
}

final class GetProductByCategoryPaginationLoadingState extends ProductsState {}

/// Get Product By Id
final class GetProductByIdLoadingState extends ProductsState {}

class GetProductByIdSuccessState extends ProductsState {
  final ProductDetailsModel productDetails;
  GetProductByIdSuccessState(this.productDetails);
}

class GetProductByIdErrorState extends ProductsState {
  final String message;
  GetProductByIdErrorState(this.message);
}

class ProductVariantSelectedState extends ProductsState {
  final Variants selectedVariant;
  ProductVariantSelectedState(this.selectedVariant);
}

class ProductVariantNotFoundState extends ProductsState {}

///
final class GetProductVariantLoadingState extends ProductsState {}

final class GetProductVariantSuccessState extends ProductsState {
  final VariantOption variant;
  GetProductVariantSuccessState(this.variant);
}

final class GetProductVariantErrorState extends ProductsState {
  final String message;
  GetProductVariantErrorState(this.message);
}

