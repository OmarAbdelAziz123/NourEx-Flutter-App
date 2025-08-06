import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/banners/data/models/banners_data_model.dart';
import 'package:nourex/features/banners/data/repos/repos.dart';

part 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit(this.bannersRepos) : super(BannersInitial()) {
    _initScrollListener();
    /// ✅ Add scroll listener on cubit creation
    getInitialBanners();
    /// ✅ Load initial data when cubit is created
  }

  final BannersRepos bannersRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<BannerModel> allBanners = [];
  BannersDataModel? bannersDataModel;
  bool isFetching = false;

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          !isFetching &&
          currentPage < totalPages) {
        getMoreBanners();
      }
    });
  }

  /// Change Index Banner
  void changeIndexBanner(int index) {
    emit(ChangeIndexBanner(index));
  }

  /// Get Initial Banners
  Future<void> getInitialBanners() async {
    emit(GetAllBannersLoadingState());
    currentPage = 1;
    allBanners.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await bannersRepos.getAllBanners(page: currentPage);

    result.when(
      success: (data) {
        allBanners = data.banners ?? [];
        bannersDataModel = data;
        totalPages = data.pagination?.pages ?? 1;
        emit(GetAllBannersSuccessState(
            banners: allBanners, isLastPage: currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetAllBannersErrorState(message: error.message.toString()));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreBanners() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetAllBannersPaginationLoadingState());
    currentPage++;

    final result = await bannersRepos.getAllBanners(page: currentPage);

    result.when(
      success: (data) {
        allBanners.addAll(data.banners ?? []);
        bannersDataModel = data;
        emit(GetAllBannersSuccessState(
            banners: allBanners, isLastPage: currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllBannersErrorState(message: error.message.toString()));
      },
    );

    isFetching = false;
  }
}
