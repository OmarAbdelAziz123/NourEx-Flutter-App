import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';
import 'package:nourex/features/my_orders/data/repos/repos.dart';

part 'my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  MyOrdersCubit(this.myOrdersRepos) : super(MyOrdersInitial()) {
    _initScrollListener();

    /// ✅ Add scroll listener on cubit creation
    getInitialAddresses(status: 'Pending');

    /// ✅ Load initial data when cubit is created
  }

  final MyOrdersRepos myOrdersRepos;

  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool isFetching = false;

  int selectedTabIndex = 0;

  MyOrdersDataModel? myOrdersDataModel;
  List<MyOrder> myOrders = [];

  /// Change Tab
  void changeTab(int index) {
    if (index == selectedTabIndex) return; // Prevent re-fetch if same tab

    selectedTabIndex = index;
    emit(ChangeTabState());
    getInitialAddresses(status: _statusFromTabIndex(index)); // Fetch new data
  }

  /// Helper to get status string
  String _statusFromTabIndex(int index) {
    switch (index) {
      case 0:
        return 'Pending';
      case 1:
        return 'Delivered';
      case 2:
        return 'Cancelled';
      default:
        return 'Pending';
    }
  }

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          currentPage < totalPages) {
        getMoreMyOrders();
      }
    });
  }

  /// Get All My Orders
  Future<void> getInitialAddresses({
    required String status,
  }) async {
    emit(GetAllMyOrdersLoadingState());
    currentPage = 1;
    myOrders.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await myOrdersRepos.getAllMyOrders(
      status: status,
      page: currentPage,
    );
    result.when(
      success: (data) {
        myOrdersDataModel = data;
        myOrders = data.result ?? [];
        totalPages = data.pagination?.pages ?? 1;
        emit(GetAllMyOrdersSuccessState(myOrders, currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetAllMyOrdersErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreMyOrders() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetAllMyOrdersPaginationLoadingState());
    currentPage++;

    final result = await myOrdersRepos.getAllMyOrders(
      status: _statusFromTabIndex(selectedTabIndex),
      page: currentPage,
    );

    result.when(
      success: (data) {
        myOrdersDataModel = data;
        myOrders.addAll(data.result ?? []);
        emit(GetAllMyOrdersSuccessState(myOrders, currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetAllMyOrdersErrorState(error.message));
      },
    );

    isFetching = false;
  }
}
