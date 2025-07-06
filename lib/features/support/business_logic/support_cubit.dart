import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  int selectedTabIndex = 0;

  /// Change Tab
  void changeTab(int index) {
    selectedTabIndex = index;
    emit(ChangeTabState());
  }
}
