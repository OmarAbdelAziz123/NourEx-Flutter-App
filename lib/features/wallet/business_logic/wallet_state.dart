part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

/// Change Tab State
final class ChangeTabState extends WalletState {}