import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;
  bool showCheckIcon = false;

  final formKey = GlobalKey<FormState>();

  Timer? countdownTimer;
  int countdown = 60;
  bool canResend = false;

  /// Toggle Password
  void userToggleObscure() {
    isObscure = !isObscure;
    emit(UserTogglePasswordState());
  }

  /// Toggle 2 Password
  void userToggle2Obscure() {
    isObscure2 = !isObscure2;
    emit(UserToggle2PasswordState());
  }

  /// Toggle Check Icon
  void userToggleCheckIcon() {
    showCheckIcon = !showCheckIcon;
    emit(UserToggleCheckIconState());
  }

  /// Start Countdown
  void startCountdown() {
    countdown = 60;
    canResend = false;
    emit(AuthCountdownChanged(countdown));

    countdownTimer?.cancel(); // إلغاء أي عدّاد سابق

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        emit(AuthCountdownChanged(countdown));
      } else {
        canResend = true;
        timer.cancel();
        emit(AuthCountdownFinished());
      }
    });
  }

  void resendCode() {
    if (canResend) {
      // TODO: Call resend logic here (API or local logic)
      startCountdown(); // Restart countdown
    }
  }

  @override
  Future<void> close() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    otpController.dispose();
    countdownTimer?.cancel();
    return super.close();
  }
}
