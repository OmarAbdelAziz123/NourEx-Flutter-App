part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

/// Toggle Password States
final class UserTogglePasswordState extends AuthState {}

final class UserToggle2PasswordState extends AuthState {}

/// Toggle Check Icon State
final class UserToggleCheckIconState extends AuthState {}

/// Countdown States
final class AuthCountdownChanged extends AuthState {
  final int countdown;

  AuthCountdownChanged(this.countdown);
}

final class AuthCountdownFinished extends AuthState {}