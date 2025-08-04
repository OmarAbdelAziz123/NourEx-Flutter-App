import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/utils/easy_loading.dart';
import 'package:nourex/features/profile/data/models/profile/profile_data_model.dart';
import 'package:nourex/features/profile/data/models/returned_orders/returned_orders_data_model.dart';
import 'package:nourex/features/profile/data/models/reviews/my_reviews_data_model.dart';
import 'package:nourex/features/profile/data/repos/repos.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepos) : super(ProfileInitial()) {
    _initScrollListener();
    /// ✅ Add scroll listener on cubit creation
    getInitialMyReviews();
    getInitialMyReturnedOrders(status: 'Return pending');
    /// ✅ Load initial data when cubit is created
  }
  final ProfileRepos profileRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool isFetching = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  bool isObscure = true;
  bool isObscure2 = true;
  bool isObscure3 = true;
  bool showCheckIcon = false;
  final formKey = GlobalKey<FormState>();

  ReturnedOrdersDataModel? returnedOrdersDataModel;
  List<ReturnedOrder> allMyReturnedOrders = [];

  ProfileDataModel? profileDataModel;
  MyReviewsDataModel? myReviewsDataModel;
  List<MyReview> allMyReviews = [];

  int selectedTabIndex = 0;


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

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          !isFetching &&
          currentPage < totalPages) {
        getMoreMyReviews();
      }
    });
  }

  /// Get All My Reviews
  Future<void> getInitialMyReviews() async {
    emit(GetAllMyReviewsLoadingState());
    currentPage = 1;
    allMyReviews.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await profileRepos.getAllMyReviews(page: currentPage);

    result.when(
      success: (success) {
        allMyReviews = success.reviews ?? [];
        totalPages = success.pagination?.pages ?? 1;
        emit(GetAllMyReviewsSuccessState(allMyReviews, currentPage >= totalPages));
      },
      failure: (failure) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllMyReviewsErrorState(failure.toString()));
      },
    );

    isFetching = false;
  }

  /// Get More My Reviews
  Future<void> getMoreMyReviews() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true; // ✅ Set fetching state
    emit(MyReviewsPaginationLoading());
    currentPage++;

    final result = await profileRepos.getAllMyReviews(page: currentPage);
    result.when(
      success: (success) {
        allMyReviews.addAll(success.reviews ?? []);
        emit(GetAllMyReviewsSuccessState(allMyReviews, currentPage >= totalPages));
      },
      failure: (failure) {
        emit(GetAllMyReviewsErrorState(failure.toString()));
      },
    );
  }

  /// Update Review
  Future<void> updateMyReview({required String productId, required String reviewId, required double rating}) async {
    showLoading();
    emit(UpdateReviewLoadingState());
    final result = await profileRepos.updateMyReview(productId, reviewId, commentController.text, rating);
    result.when(
      success: (success) {
        hideLoading();
        emit(UpdateReviewSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(UpdateReviewErrorState(failure.toString()));
      },
    );
  }

  /// Delete Review
  Future<void> deleteMyReview({required String productId, required String reviewId}) async {
    showLoading();
    emit(DeleteReviewLoadingState());
    final result = await profileRepos.deleteMyReview(productId, reviewId);
    result.when(
      success: (success) {
        hideLoading();
        emit(DeleteReviewSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(DeleteReviewErrorState(failure.toString()));
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
        AppConstants.userToken = '';
        emit(LogoutSuccessState());
      },
      failure: (failure) {
        hideLoading();
        emit(LogoutErrorState());
      },
    );
  }

  /// Get All My Returned Orders
  Future<void> getInitialMyReturnedOrders({required String status}) async {
    emit(GetAllMyReturnedOrdersLoadingState());
    currentPage = 1;
    allMyReturnedOrders.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await profileRepos.getAllMyReturnedOrders(page: currentPage, status: status);

    result.when(
      success: (success) {
        returnedOrdersDataModel = success;
        allMyReturnedOrders = success.result ?? [];
        totalPages = success.pagination?.pages ?? 1;
        emit(GetAllMyReturnedOrdersSuccessState(allMyReturnedOrders, currentPage >= totalPages));
      },
      failure: (failure) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllMyReturnedOrdersErrorState(failure.toString()));
      },
    );

    isFetching = false;
  }

  /// Fetch More for Pagination
  Future<void> getMoreMyReturnedOrders({required String status}) async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetAllMyReturnedOrdersPaginationLoadingState());
    currentPage++;

    final result = await profileRepos.getAllMyReturnedOrders(page: currentPage, status: status);

    result.when(
      success: (success) {
        returnedOrdersDataModel = success;
        allMyReturnedOrders.addAll(success.result ?? []);
        emit(GetAllMyReturnedOrdersSuccessState(allMyReturnedOrders, currentPage >= totalPages));
      },
      failure: (failure) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllMyReturnedOrdersErrorState(failure.toString()));
      },
    );

    isFetching = false;
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

  /// Change Tab
  void changeTab(int index) {
    if (index == selectedTabIndex) return; // Prevent re-fetch if same tab

    selectedTabIndex = index;
    emit(ChangeTabState());
    getInitialMyReturnedOrders(status: _statusFromTabIndex(index)); // Fetch new data
  }

  /// Helper to get status string
  String _statusFromTabIndex(int index) {
    switch (index) {
      case 0:
        return 'Return pending';
      case 1:
        return 'Return accepted';
      case 2:
        return 'Return rejected';
      default:
        return 'Return pending';
    }
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
