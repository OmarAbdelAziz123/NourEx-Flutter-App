import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/auth/data/models/user_data_model.dart';
import 'package:nourex/features/auth/data/repos/repos.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepos) : super(AuthInitial());

  final AuthRepos authRepos;
  UserDataModel? userDataModel;

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

  /// Login Function
  Future<void> login() async {
    showLoading();
    emit(LoginLoadingState());

    final result = await authRepos.login(
      phoneOrEmail: emailController.text,
      password: passwordController.text,
      acceptTerms: showCheckIcon,
      fcmToken: CacheHelper.getData(key: CacheKeys.deviceToken) ?? 'Empty',
    );

    result.when(
      success: (success) {
        hideLoading();
        userDataModel = success;
        emit(LoginSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(LoginErrorState(failure.toString()));
      },
    );
  }

  /// Forget Password Function
  Future<void> forgetPassword() async {
    showLoading();
    emit(ForgetPasswordLoadingState());

    final result = await authRepos.forgetPassword(email: emailController.text);

    result.when(
      success: (success) {
        hideLoading();
        emit(ForgetPasswordSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(ForgetPasswordErrorState(failure.toString()));
      },
    );
  }

  /// Confirm Forget Password Function
  Future<void> confirmForgetPassword({required String email}) async {
    showLoading();
    emit(ConfirmPhoneEmailOTPLoadingState());

    final result = await authRepos.confirmPhoneEmailOTP(
      phoneOrEmail: email,
      otp: otpController.text,
    );

    result.when(
      success: (success) {
        hideLoading();
        emit(ConfirmPhoneEmailOTPSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(ConfirmPhoneEmailOTPErrorState(failure.toString()));
      },
    );
  }

  /// Register Function
  Future<void> register() async {
    showLoading();
    emit(RegisterLoadingState());

    final result = await authRepos.register(
      name: userNameController.text,
      email: emailController.text,
      phone: '+963${phoneController.text}',
      acceptTerms: showCheckIcon,
    );

    result.when(
      success: (success) {
        hideLoading();
        emit(RegisterSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(RegisterErrorState(failure.toString()));
      },
    );
  }

  /// Set Password Function
  Future<void> setPassword({required String email}) async {
    showLoading();
    emit(SetPasswordLoadingState());

    final result = await authRepos.setPassword(
      phoneOrEmail: email,
      password: passwordController.text,
      cPassword: confirmPasswordController.text,
    );

    result.when(
      success: (success) {
        hideLoading();
        emit(SetPasswordSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(SetPasswordErrorState(failure.toString()));
      },
    );
  }

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
      forgetPassword();
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
