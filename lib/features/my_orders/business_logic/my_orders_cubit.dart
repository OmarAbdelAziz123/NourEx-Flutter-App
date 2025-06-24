import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit() : super(MyOrdersInitial());

  int selectedTabIndex = 0;

  /// Change Tab
  void changeTab(int index) {
    selectedTabIndex = index;
    emit(ChangeTabState());
  }
}
