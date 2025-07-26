part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

/// Toggle Password States
final class UserTogglePasswordState extends ProfileState {}

final class UserToggle2PasswordState extends ProfileState {}

final class UserToggle3PasswordState extends ProfileState {}

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

/// Logout States
final class LogoutLoadingState extends ProfileState {}

final class LogoutSuccessState extends ProfileState {}

final class LogoutErrorState extends ProfileState {}