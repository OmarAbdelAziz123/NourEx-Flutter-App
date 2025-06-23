import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(context) => BlocProvider.of(context);
  void changeBottomNavBar(index) {
    AppConstants.mainLayoutInitialScreenIndex = index;
    emit(AppBottomNavState(AppConstants.mainLayoutInitialScreenIndex));
  }
}
