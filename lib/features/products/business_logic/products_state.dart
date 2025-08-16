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

/// Get All Best Offers
class GetAllBestOffersLoadingState extends ProductsState {}

class GetAllBestOffersSuccessState extends ProductsState {
  final List<ProductModel> products;
  final bool isLastPage;

  GetAllBestOffersSuccessState(this.products, this.isLastPage);
}

class GetAllBestOffersErrorState extends ProductsState {
  final String message;
  GetAllBestOffersErrorState(this.message);
}

final class GetAllBestOffersPaginationLoadingState extends ProductsState {}

/// Get All Best Seller
class GetAllBestSellerLoadingState extends ProductsState {}

class GetAllBestSellerSuccessState extends ProductsState {
  final List<ProductModel> products;
  final bool isLastPage;

  GetAllBestSellerSuccessState(this.products, this.isLastPage);
}

class GetAllBestSellerErrorState extends ProductsState {
  final String message;
  GetAllBestSellerErrorState(this.message);
}

final class GetAllBestSellerPaginationLoadingState extends ProductsState {}

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

// Add these states to your existing products_state.dart file

class VariantSelectionUpdated extends ProductsState {
  final Map<String, String?> selectedVariants;
  final num? selectedPrice;

  VariantSelectionUpdated(this.selectedVariants, this.selectedPrice);

  @override
  List<Object?> get props => [selectedVariants, selectedPrice];
}

class MainImageUpdated extends ProductsState {
  final String imageUrl;

  MainImageUpdated(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

/// Get Product Reviews
final class GetProductReviewsLoadingState extends ProductsState {}

class GetProductReviewsSuccessState extends ProductsState {
  final List<ProductReview> reviews;
  final bool isLastPage;

  GetProductReviewsSuccessState( this.reviews, this.isLastPage);
}

class GetProductReviewsErrorState extends ProductsState {
  final String message;
  GetProductReviewsErrorState(this.message);
}

final class ProductReviewsPaginationLoading extends ProductsState {}