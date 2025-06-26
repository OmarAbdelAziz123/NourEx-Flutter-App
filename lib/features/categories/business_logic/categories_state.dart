part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

/// Change Category
class ProductsCategoryChanged extends CategoriesState {
  final int selectedIndex;
  ProductsCategoryChanged(this.selectedIndex);
}