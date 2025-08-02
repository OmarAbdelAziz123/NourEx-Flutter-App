part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

/// Change Tab State
final class ChangeTabState extends WalletState {}

/// Get Wallet History States
final class GetWalletHistoryLoadingState extends WalletState {}

final class GetWalletHistorySuccessState extends WalletState {}

final class GetWalletHistoryErrorState extends WalletState {
  final String message;
  GetWalletHistoryErrorState(this.message);
}

/// Make Preview Redeem Points States
final class MakePreviewRedeemPointsLoadingState extends WalletState {}

final class MakePreviewRedeemPointsSuccessState extends WalletState {
  final String redeemedAmount;
  MakePreviewRedeemPointsSuccessState({required this.redeemedAmount});
}

final class MakePreviewRedeemPointsErrorState extends WalletState {
  final String message;
  MakePreviewRedeemPointsErrorState(this.message);
}

/// Redeem Points States
final class RedeemPointsLoadingState extends WalletState {}

final class RedeemPointsSuccessState extends WalletState {}

final class RedeemPointsErrorState extends WalletState {
  final String message;
  RedeemPointsErrorState(this.message);
}