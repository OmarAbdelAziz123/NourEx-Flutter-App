import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/data/models/order_data_model.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_order_container_widget.dart';

class StatusOrdersWidget extends StatelessWidget {
  const StatusOrdersWidget({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyOrdersCubit>();

    return BlocBuilder<MyOrdersCubit, MyOrdersState>(
      buildWhen: (previous, current) =>
          current is GetAllMyOrdersLoadingState ||
          current is GetAllMyOrdersSuccessState ||
          current is GetAllMyOrdersErrorState ||
          current is GetAllMyOrdersPaginationLoadingState,
      builder: (context, state) {
        final ordersList = cubit.myOrders;

        return CustomRefreshIndicatorWidget(
            controller: cubit.scrollController,
            refreshIndicatorKey: cubit.refreshIndicatorKey,
            onRefresh: () => cubit.getInitialAddresses(status: status),
            slivers: [
              if (ordersList.isEmpty && state is GetAllMyOrdersLoadingState)
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                  sliver: SliverList.separated(
                    itemCount: 6,
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) =>
                        const CustomOrderContainerSkeletonWidget(),
                  ),
                )
              else if (ordersList.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Text(
                        'noOrders'.tr(),
                        style: Styles.contentRegular.copyWith(
                          color: AppColors.neutralColor600,
                        ),
                      ),
                    ),
                  ),
                )
              else ...[
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                  sliver: SliverList.separated(
                    itemCount: ordersList.length,
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => context.pushNamed(
                        Routes.orderDetailsScreen,
                        arguments: ordersList[index],
                      ),
                      child: CustomOrderContainerWidget(
                        orderDataModel: ordersList[index],
                      ),
                    ),
                  ),
                ),
                if (state is GetAllMyOrdersPaginationLoadingState)
                  const SliverToBoxAdapter(
                    child: CustomLoadingWhenLoadingMoreWidget(),
                  ),
              ],
              SliverToBoxAdapter(child: 18.verticalSpace),
            ]);
      },
    );
  }
}
