import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/profile/data/models/profile/profile_data_model.dart';
import 'package:nourex/features/profile/data/repos/repos.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepos) : super(ProfileInitial());

  final ProfileRepos profileRepos;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  bool isObscure = true;
  bool isObscure2 = true;
  bool isObscure3 = true;
  bool showCheckIcon = false;
  final formKey = GlobalKey<FormState>();

  ProfileDataModel? profileDataModel;

  void setProfileControllers() {
    final data = profileDataModel?.data;
    if (data != null) {
      nameController.text = data.name ?? '';
      emailController.text = data.email ?? '';
      phoneController.text = data.phone ?? '';
      ageController.text = data.age?.toString() ?? '';
      profileImage = data.profilePic != null ? File(data.profilePic!) : null;
    }
  }

  bool get isDataChanged {
    final originalData = profileDataModel?.data;
    if (originalData == null) return false;

    return nameController.text.trim() != originalData.name?.trim() ||
        emailController.text.trim() != originalData.email?.trim() ||
        phoneController.text.trim() != originalData.phone?.trim() ||
        ageController.text.trim() != originalData.age.toString().trim() ||
        profileImage != null;
  }

  /// Get Profile
  Future<void> getProfile() async {
    emit(GetProfileLoadingState());

    final result = await profileRepos.getProfile();

    result.when(
      success: (success) {
        profileDataModel = success;
        setProfileControllers();
        emit(GetProfileSuccessState(success));
      },
      failure: (failure) {
        emit(GetProfileErrorState());
      },
    );
  }

  /// Choose Image
  Future<void> chooseImageFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        profileImage = File(pickedFile.path);
        emit(ProfileImageSelectedState());
      }
    } catch (e) {
      print('Error picking image: $e');
      emit(ProfileImageErrorState());
    }
  }

  /// Update Profile
  Future<void> updateProfile() async {
    showLoading();
    emit(UpdateProfileLoadingState());

    final result = await profileRepos.updateProfile(
      nameController.text,
      emailController.text,
      phoneController.text,
      ageController.text,
      profileImage,
    );

    result.when(
      success: (success) {
        hideLoading();
        emit(UpdateProfileSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(UpdateProfileErrorState());
      },
    );
  }

  /// Logout
  Future<void> userLogout() async {
    showLoading();
    emit(LogoutLoadingState());

    final result = await profileRepos.userLogout();

    result.when(
      success: (success) async {
        hideLoading();
        await CacheHelper.clearAllSecuredData();
        emit(LogoutSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(LogoutErrorState());
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

  /// Toggle 3 Password
  void userToggle3Obscure() {
    isObscure3 = !isObscure3;
    emit(UserToggle3PasswordState());
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    ageController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    profileImage?.delete();
    return super.close();
  }
}
