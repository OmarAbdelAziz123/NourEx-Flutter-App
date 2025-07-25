import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  /// Change Index Banner
  void changeIndexBanner(int index) {
    emit(ChangeIndexBanner(index));
  }
}
