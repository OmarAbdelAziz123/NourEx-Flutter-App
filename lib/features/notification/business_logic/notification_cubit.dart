import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:nourex/features/addresses/business_logic/addresses_cubit.dart';
import 'package:nourex/features/notification/data/models/all_notifications_data_model.dart';
import 'package:nourex/features/notification/data/repos/repos.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepos) : super(NotificationInitial()){
    _initScrollListener();

    /// ✅ Add scroll listener on cubit creation
    getInitialNotifications();

    /// ✅ Load initial data when cubit is created
  }

  final NotificationRepos notificationRepos;
  int currentPage = 1;
  int totalPages = 1;
  final ScrollController scrollController = ScrollController();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  bool isFetching = false;

  AllNotificationsDataModel? allNotificationsDataModel;
  List<NotificationItem> notifications = [];

  /// Init Scroll Listener
  void _initScrollListener() {
    scrollController.addListener(() {
      final position = scrollController.position;

      /// ✅ Only trigger when user scrolls down
      if (position.userScrollDirection == ScrollDirection.reverse &&
          position.pixels >= position.maxScrollExtent - 100 &&
          currentPage < totalPages) {
        getMoreNotifications();
      }
    });
  }

  /// Get All Notifications
  Future<void> getInitialNotifications() async {
    emit(GetNotificationsLoadingState());
    currentPage = 1;
    notifications.clear();
    isFetching = false; // ✅ Reset fetching state

    final result = await notificationRepos.getAllNotifications(page: currentPage);

    result.when(
      success: (data) {
        allNotificationsDataModel = data;
        notifications = data.result ?? [];
        totalPages = data.pages ?? 1;
        emit(GetNotificationsSuccessState(notifications, currentPage >= totalPages));
      },
      failure: (error) {
        emit(GetNotificationsErrorState(error.message));
      },
    );
  }

  /// Fetch More for Pagination
  Future<void> getMoreNotifications() async {
    if (isFetching || currentPage >= totalPages) return;

    isFetching = true;
    emit(GetNotificationsPaginationLoadingState());
    currentPage++;

    final result = await notificationRepos.getAllNotifications(page: currentPage);

    result.when(
      success: (data) {
        allNotificationsDataModel = data;
        notifications.addAll(data.result ?? []);
        emit(GetNotificationsSuccessState(notifications, currentPage >= totalPages));
      },
      failure: (error) {
        currentPage--; // ✅ Revert page increment on error
        emit(GetNotificationsErrorState(error.message));
      },
    );

    isFetching = false;
  }
}
