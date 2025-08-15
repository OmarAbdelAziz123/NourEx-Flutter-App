part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

/// Toggle Password States
final class UserTogglePasswordState extends ProfileState {}

final class UserToggle2PasswordState extends ProfileState {}

final class UserToggle3PasswordState extends ProfileState {}

/// Change Tab State
final class ChangeTabState extends ProfileState {}


/// Get Profile States
final class GetProfileLoadingState extends ProfileState {}

final class GetProfileSuccessState extends ProfileState {
  final ProfileDataModel profileDataModel;
  GetProfileSuccessState(this.profileDataModel);
}

final class GetProfileErrorState extends ProfileState {}

/// Choose Image States
final class ProfileImageSelectedState extends ProfileState {}

final class ProfileImageErrorState extends ProfileState {}

/// Update Profile States
final class UpdateProfileLoadingState extends ProfileState {}

final class UpdateProfileSuccessState extends ProfileState {}

final class UpdateProfileErrorState extends ProfileState {}

/// Get All My Reviews States
final class GetAllMyReviewsLoadingState extends ProfileState {}

final class GetAllMyReviewsSuccessState extends ProfileState {
  final List<MyReview> myReviews;
  final bool isLastPage;

  GetAllMyReviewsSuccessState( this.myReviews, this.isLastPage);
}

final class GetAllMyReviewsErrorState extends ProfileState {
  final String error;
  GetAllMyReviewsErrorState(this.error);
}

final class MyReviewsPaginationLoading extends ProfileState {}

/// Delete Review States
final class DeleteReviewLoadingState extends ProfileState {}

final class DeleteReviewSuccessState extends ProfileState {}

final class DeleteReviewErrorState extends ProfileState {
  final String error;
  DeleteReviewErrorState(this.error);
}

/// Update Review States
final class UpdateReviewLoadingState extends ProfileState {}

final class UpdateReviewSuccessState extends ProfileState {}

final class UpdateReviewErrorState extends ProfileState {
  final String error;
  UpdateReviewErrorState(this.error);
}

/// Make Report Review States
final class MakeReportReviewLoadingState extends ProfileState {}

final class MakeReportReviewSuccessState extends ProfileState {}

final class MakeReportReviewErrorState extends ProfileState {
  final String error;
  MakeReportReviewErrorState(this.error);
}

/// Logout States
final class LogoutLoadingState extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutErrorState extends ProfileState {}

/// Get All My Returned Orders States
final class GetAllMyReturnedOrdersLoadingState extends ProfileState {}

final class GetAllMyReturnedOrdersSuccessState extends ProfileState {
  final List<ReturnedOrder> myReturnedOrders;
  final bool isLastPage;

  GetAllMyReturnedOrdersSuccessState( this.myReturnedOrders, this.isLastPage);
}

final class GetAllMyReturnedOrdersErrorState extends ProfileState {
  final String error;
  GetAllMyReturnedOrdersErrorState(this.error);
}

final class GetAllMyReturnedOrdersPaginationLoadingState extends ProfileState {}