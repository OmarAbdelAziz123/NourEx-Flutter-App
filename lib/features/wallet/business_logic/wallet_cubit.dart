import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  int selectedTabIndex = 0;

  /// Change Tab
  void changeTab(int index) {
    selectedTabIndex = index;
    emit(ChangeTabState());
  }
}
