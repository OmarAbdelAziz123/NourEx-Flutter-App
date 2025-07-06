part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

/// Change index of banner
final class ChangeIndexBanner extends HomeState {
  final int index;
  ChangeIndexBanner(this.index);
}