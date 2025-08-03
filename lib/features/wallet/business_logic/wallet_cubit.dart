import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/wallet/data/models/wallet_data_model.dart';
import 'package:nourex/features/wallet/data/repos/repos.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this.walletRepos) : super(WalletInitial());

  final WalletRepos walletRepos;

  WalletDataModel? walletDataModel;
  int selectedTabIndex = 0;

  TextEditingController numberOfPointsController = TextEditingController();
  TextEditingController redeemedAmountController = TextEditingController();

  /// Change Tab
  void changeTab(int index) {
    selectedTabIndex = index;
    emit(ChangeTabState());
  }

  /// Get Wallet History
  Future<void> getWalletHistory({required String type}) async {
    emit(GetWalletHistoryLoadingState());
    final result = await walletRepos.getWalletHistory(type: type);
    result.when(
      success: (data) {
        walletDataModel = data;
        emit(GetWalletHistorySuccessState());
      },
      failure: (error) {
        emit(GetWalletHistoryErrorState(error.message));
      },
    );
  }

  /// Make Redeem Points Preview
  Future<void> makePreviewRedeemPoints() async {
    final inputText = numberOfPointsController.text.trim();
    if (inputText.isEmpty) return;

    final points = int.tryParse(inputText);
    if (points == null || points <= 0) return;

    showLoading();
    emit(MakePreviewRedeemPointsLoadingState());

    final result = await walletRepos.makePreviewRedeemPoints(requestedPoints: points);

    result.when(
      success: (redeemedAmount) {
        hideLoading();
        redeemedAmountController.text = redeemedAmount.toString();
        emit(MakePreviewRedeemPointsSuccessState(redeemedAmount: redeemedAmount));
      },
      failure: (error) {
        hideLoading();
        emit(MakePreviewRedeemPointsErrorState(error.message));
      },
    );
  }

  /// Redeem Points
  Future<void> redeemPoints() async {
    showLoading();
    emit(RedeemPointsLoadingState());
    final result = await walletRepos.redeemPoints(requestedPoints: int.parse(numberOfPointsController.text.trim()));
    result.when(
      success: (redeemedAmount) {
        redeemedAmountController.text = redeemedAmount.toString();
        hideLoading();
        emit(RedeemPointsSuccessState());
      },
      failure: (error) {
        hideLoading();
        emit(RedeemPointsErrorState(error.message));
      },
    );
  }
}
