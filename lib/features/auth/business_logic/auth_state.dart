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

/// Login States
final class LoginLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class LoginErrorState extends AuthState {
  final String error;

  LoginErrorState(this.error);
}

/// Forget Password
final class ForgetPasswordLoadingState extends AuthState {}

final class ForgetPasswordSuccessState extends AuthState {}

final class ForgetPasswordErrorState extends AuthState {
  final String error;

  ForgetPasswordErrorState(this.error);
}

/// Confirm Email OTP
final class ConfirmPhoneEmailOTPLoadingState extends AuthState {}

final class ConfirmPhoneEmailOTPSuccessState extends AuthState {}

final class ConfirmPhoneEmailOTPErrorState extends AuthState {
  final String error;

  ConfirmPhoneEmailOTPErrorState(this.error);
}

/// Register States
final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}

/// Set Password States
final class SetPasswordLoadingState extends AuthState {}

final class SetPasswordSuccessState extends AuthState {}

final class SetPasswordErrorState extends AuthState {
  final String error;

  SetPasswordErrorState(this.error);
}