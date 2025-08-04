import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/core/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_container_in_order_details_to_connect_the_three_status_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/time_line_stage_widget.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/data/models/returned_orders/returned_orders_data_model.dart';

import '../../../my_orders/presentation/widgets/custom_order_container_widget.dart';

class ReturnedOrdersScreen extends StatelessWidget {
  const ReturnedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'returnOrders'.tr(),
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();

          return Column(
            children: [
              CustomTabBarWidget(
                tabs: ['pending'.tr(), 'returned2'.tr(), 'rejectedd'.tr()],
                selectedIndex: cubit.selectedTabIndex,
                onTabChanged: (index) {
                  cubit.changeTab(index);
                },
              ),
              Expanded(
                child: _buildTabContent(cubit.selectedTabIndex),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabContent(currentTabIndex) {
    switch (currentTabIndex) {
      case 0:
        return ReturnedOrdersWidget(
          status: 'Return pending',
        );
      case 1:
        return ReturnedOrdersWidget(
          status: 'Return accepted',
        );
      case 2:
        return ReturnedOrdersWidget(
          status: 'Return rejected',
        );
      default:
        return Container();
    }
  }
}

class ReturnedOrdersWidget extends StatelessWidget {
  const ReturnedOrdersWidget({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is GetAllMyReturnedOrdersLoadingState ||
          current is GetAllMyReturnedOrdersSuccessState ||
          current is GetAllMyReturnedOrdersErrorState ||
          current is GetAllMyReturnedOrdersPaginationLoadingState,
      builder: (context, state) {
        final returnedOrdersList = cubit.allMyReturnedOrders;

        return CustomRefreshIndicatorWidget(
          controller: cubit.scrollController,
          refreshIndicatorKey: cubit.refreshIndicatorKey,
          onRefresh: () => cubit.getInitialMyReturnedOrders(status: status),
          slivers: [
            if (returnedOrdersList.isEmpty &&
                state is GetAllMyReturnedOrdersLoadingState)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                sliver: SliverList.separated(
                  itemCount: 6,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) =>
                      const CustomOrderContainerSkeletonWidget(),
                ),
              )
            else if (returnedOrdersList.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Text('لا يوجد طلبات إرجاع'),
                  ),
                ),
              )
            else ...[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                sliver: SliverList.separated(
                  itemCount: returnedOrdersList.length,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.pushNamed(
                      Routes.returnedOrderDetailsScreen,
                      arguments: returnedOrdersList[index],
                    ),
                    child: CustomReturnOrderContainerWidget(
                      orderDataModel: returnedOrdersList[index],
                    ),
                  ),
                ),
              ),
              if (state is GetAllMyReturnedOrdersPaginationLoadingState)
                const SliverToBoxAdapter(
                  child: CustomLoadingWhenLoadingMoreWidget(),
                ),
            ],
            SliverToBoxAdapter(child: 18.verticalSpace),
          ],
        );
      },
    );
  }
}

class ReturnedOrderDetailsScreen extends StatelessWidget {
  const ReturnedOrderDetailsScreen({super.key, required this.returnedOrder});

  final ReturnedOrder returnedOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: '${'returnNumber'.tr()} : ${returnedOrder.returnSeq}',
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,
              Text('executionSteps'.tr(), style: Styles.highlightEmphasis),
              12.verticalSpace,

              /// Status Timeline with IntrinsicHeight for better alignment
              buildReturnStatusTimeline('Return pending'),
              // buildReturnStatusTimeline('Return accepted'),
              // buildReturnStatusTimeline('Returned'),
              // buildReturnStatusTimeline('Return rejected'),
              // buildReturnStatusTimeline(returnedOrder.order!.status ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReturnStatusTimeline(String status) {
    return Column(
      children: [
        /// Step 1: Return pending
        Column(children: [
          /// First Stage Pending
          IntrinsicHeight(
            child: Row(
              spacing: 16.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      status == 'Return pending'
                          ? 'assets/svgs/pending_icon1.svg'
                          : 'assets/svgs/pending_icon3.svg',
                    ),
                    CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(),
                  ],
                ),
                TimelineStageWidget(
                  stage: 'firstStep'.tr(),
                  status: status == 'Return pending'
                      ? 'pending'.tr()
                      : 'completed'.tr(),
                  description: 'firstStepDescription'.tr(),
                  buttonText: status == 'Return pending'
                      ? "جاري العمل عليه"
                      : 'completed'.tr(),
                  isCompleted: status != 'Return pending',
                  inProgressColor: status == 'Return pending',
                ),
              ],
            ),
          ),
          status == 'Return accepted' || status == 'Returned'
              ? Column(
                  children: [
                    /// Returned Accepted
                    IntrinsicHeight(
                      child: Row(
                        spacing: 16.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                status == 'Return pending'
                                    ? 'assets/svgs/delevering_icon2.svg'
                                    : status == 'Return accepted'
                                        ? 'assets/svgs/delevering_icon3.svg'
                                        : 'assets/svgs/delevering_icon1.svg',
                              ),
                              CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(),
                            ],
                          ),
                          TimelineStageWidget(
                            stage: 'secondStep'.tr(),
                            // status: 'secondStepDescription'.tr(),
                            status: 'secondStepDescription'.tr(),
                            description: 'thirdStep'.tr(),
                            // buttonText: 'fourthStep'.tr(),
                            buttonText: status == 'Return pending'
                                ? "جاري العمل عليه"
                                : 'completed'.tr(),
                            isCompleted: status == 'Return accepted' || status == 'Returned',
                            inProgressColor: status == 'Return accepted',
                          ),
                        ],
                      ),
                    ),

                    /// Accepted
                    IntrinsicHeight(
                      child: Row(
                        spacing: 16.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(status == 'Returned pending' ||
                                      status == 'Return accepted'
                                  ? 'assets/svgs/delevered_icon2.svg'
                                  : 'assets/svgs/delevered_icon1.svg'),
                            ],
                          ),
                          TimelineStageWidget(
                            stage: 'thirdStepDescription'.tr(),
                            // status: 'secondStepDescription'.tr(),
                            status: 'returned2'.tr(),
                            description: 'description3'.tr(),
                            // buttonText: 'fourthStep'.tr(),
                            buttonText: status == 'Return pending' ||
                                    status == 'Return accepted'
                                ? "pending".tr()
                                : 'completed'.tr(),
                            isCompleted: status == 'Returned',
                            inProgressColor:
                                status == 'Returned',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        spacing: 16.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                status == 'Return rejected'
                                    ? 'assets/svgs/cancelled)icon.svg'
                                    : 'assets/svgs/cancelled)icon.svg',
                              ),
                            ],
                          ),
                          TimelineStageWidget(
                            stage: 'rejectedd'.tr(),
                            // status: 'secondStepDescription'.tr(),
                            status: 'rejectedd'.tr(),
                            description: 'thirdStep'.tr(),
                            // buttonText: 'fourthStep'.tr(),
                            buttonText: 'rejectedd'.tr(),
                            isCancelled: true,
                            isCompleted: status == 'Return rejected',
                            inProgressColor: status == 'Return rejected',
                          ),
                        ],
                      ),
                    ),
                  ],
                )
        ]

            /// Second Stage

            )

        /// Step 2: Return accepted or rejected
        /// Step 3: Final
      ],
    );
  }
}
