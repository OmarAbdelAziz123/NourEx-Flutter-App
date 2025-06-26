import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  int selectedCategoryIndex = 0;

  /// Change Category
  void changeCategoryIndex(int index) {
    selectedCategoryIndex = index;
    emit(ProductsCategoryChanged(index));
  }
}
