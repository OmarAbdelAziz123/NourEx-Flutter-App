import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/profile/data/repos/repos.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepos) : super(ProfileInitial());

  final ProfileRepos profileRepos;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
  TextEditingController();

  bool isObscure = true;
  bool isObscure2  = true;
  bool isObscure3  = true;
  bool showCheckIcon = false;
  final formKey = GlobalKey<FormState>();

  /// Logout
  Future<void> userLogout() async {
    showLoading();
    emit(LogoutLoadingState());

    final result = await profileRepos.userLogout();

    result.when(success: (success) async {
      hideLoading();
      await CacheHelper.clearAllSecuredData();
      emit(LogoutSuccessState());
    }, failure: (failure) {
      hideLoading();
      emit(LogoutErrorState());
    });
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

  /// Toggle 3 Password
  void userToggle3Obscure() {
    isObscure3 = !isObscure3;
    emit(UserToggle3PasswordState());
  }



  @override
  Future<void> close() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    return super.close();
  }
}
