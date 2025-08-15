import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/notification/business_logic/notification_cubit.dart';
import 'package:nourex/features/notification/data/models/all_notifications_data_model.dart';
import 'package:nourex/features/notification/presentation/widgets/notification_item_widget.dart';
import 'package:nourex/features/notification/presentation/widgets/notification_skeleton_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'الإشعارات',
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        buildWhen: (previous, current) =>
        current is GetNotificationsLoadingState ||
            current is GetNotificationsSuccessState ||
            current is GetNotificationsErrorState ||
            current is GetNotificationsPaginationLoadingState,
        builder: (context, state) {
          final cubit = context.read<NotificationCubit>();
          final notifications = cubit.notifications;

          return CustomRefreshIndicatorWidget(
            controller: cubit.scrollController,
            refreshIndicatorKey: cubit.refreshIndicatorKey,
            onRefresh: () => cubit.getInitialNotifications(),
            slivers: [
              // Loading State for Initial Load
              if (notifications.isEmpty && state is GetNotificationsLoadingState)
                SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverList.separated(
                    itemCount: 8,
                    separatorBuilder: (context, index) => 12.verticalSpace,
                    itemBuilder: (context, index) => const NotificationSkeletonWidget(),
                  ),
                )
              // Empty State
              else if (notifications.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _buildEmptyState(),
                )
              // Notifications List
              else ...[
                  SliverPadding(
                    padding: EdgeInsets.all(16.w),
                    sliver: SliverList.separated(
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => 12.verticalSpace,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return NotificationItemWidget(
                          notification: notification,
                          onTap: () => _handleNotificationTap(context, notification),
                        );
                      },
                    ),
                  ),
                  // Pagination Loading
                  if (state is GetNotificationsPaginationLoadingState)
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      sliver: const SliverToBoxAdapter(
                        child: CustomLoadingWhenLoadingMoreWidget(),
                      ),
                    ),
                ],
              // Bottom Spacing
              SliverToBoxAdapter(child: 20.verticalSpace),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: 64.sp,
              color: Colors.grey[400],
            ),
          ),
          20.verticalSpace,
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          8.verticalSpace,
          Text(
            'ستظهر الإشعارات الجديدة هنا',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(BuildContext context, NotificationItem notification) {
    // Handle notification tap - navigate or show details
    // You can implement navigation logic here
  }

}