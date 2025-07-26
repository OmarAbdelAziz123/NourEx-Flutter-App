part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

/// Change Category
class ProductsCategoryChanged extends CategoriesState {
  final int selectedIndex;

  ProductsCategoryChanged(this.selectedIndex);
}

/// Get All Categories States
final class GetAllCategoriesLoadingState extends CategoriesState {}

final class GetAllCategoriesSuccessState extends CategoriesState {
  final List<CategoryModel> categories;
  final bool isLastPage;

  GetAllCategoriesSuccessState(this.categories, this.isLastPage);
}

final class GetAllCategoriesErrorState extends CategoriesState {
  final String error;

  GetAllCategoriesErrorState(this.error);
}

final class CategoriesPaginationLoading extends CategoriesState {}
