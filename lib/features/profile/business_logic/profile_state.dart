part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

/// Toggle Password States
final class UserTogglePasswordState extends ProfileState {}

final class UserToggle2PasswordState extends ProfileState {}

final class UserToggle3PasswordState extends ProfileState {}
