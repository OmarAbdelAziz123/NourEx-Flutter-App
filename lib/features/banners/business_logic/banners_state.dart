part of 'banners_cubit.dart';

@immutable
sealed class BannersState {}

final class BannersInitial extends BannersState {}

/// Change index of banner
final class ChangeIndexBanner extends BannersState {
  final int index;
  ChangeIndexBanner(this.index);
}

/// Get All Banners
final class GetAllBannersLoadingState extends BannersState {}

final class GetAllBannersSuccessState extends BannersState {
  final List<BannerModel> banners;
  final bool isLastPage;

  GetAllBannersSuccessState({required this.banners, required this.isLastPage});
}

final class GetAllBannersErrorState extends BannersState {
  final String message;
  GetAllBannersErrorState({required this.message});
}

final class GetAllBannersPaginationLoadingState extends BannersState {}