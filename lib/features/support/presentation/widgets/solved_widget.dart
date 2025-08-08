import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';
import 'package:nourex/features/support/presentation/widgets/custom_ticket_container_widget.dart';

class SolvedWidget extends StatelessWidget {
  const SolvedWidget({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupportCubit>();

    return BlocBuilder<SupportCubit, SupportState>(
      buildWhen: (previous, current) =>
          current is GetAllSupportDataLoadingState ||
          current is GetAllSupportDataSuccessState ||
          current is GetAllSupportDataErrorState ||
          current is GetAllSupportDataPaginationLoadingState,
      builder: (context, state) {
        final ticketsList = cubit.supports;

        return CustomRefreshIndicatorWidget(
          controller: cubit.scrollController,
          refreshIndicatorKey: cubit.refreshIndicatorKey,
          onRefresh: () => cubit.getInitialSupportData(
            status: cubit.selectedTabIndex == 0
                ? 'Completed'
                : cubit.selectedTabIndex == 1
                    ? 'In Progress'
                    : 'Rejected',
          ),
          slivers: [
            /// Loading State (first load)
            if (ticketsList.isEmpty && state is GetAllSupportDataLoadingState)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                sliver: SliverList.separated(
                  itemCount: 6,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) =>
                      const CustomTicketContainerSkeletonizerWidget(),
                ),
              )

            /// Empty State
            else if (ticketsList.isEmpty)
              SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Text('لا يوجد تذاكر حالية'),
                  ),
                ),
              )

            /// Data State
            else ...[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                sliver: SliverList.separated(
                  itemCount: ticketsList.length,
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => context.pushNamed(
                      Routes.supportDetailsScreenRoute,
                      arguments: {
                        'ticketId': ticketsList[index].id,
                        'ticketSeq': ticketsList[index].ticketSeq,
                        'status': ticketsList[index].status,
                      },
                    ).then(
                      (value) => cubit.getInitialSupportData(
                        status: cubit.selectedTabIndex == 0
                            ? 'Completed'
                            : cubit.selectedTabIndex == 1
                                ? 'In Progress'
                                : 'Rejected',
                      ),
                    ),
                    child: CustomTicketContainerWidget(
                      solvedOrdersDataModel: ticketsList[index],
                    ),
                  ),
                ),
              ),

              /// Pagination Loading
              if (state is GetAllSupportDataPaginationLoadingState)
                const SliverToBoxAdapter(
                  child: CustomLoadingWhenLoadingMoreWidget(),
                ),
            ],

            /// Bottom Spacing
            SliverToBoxAdapter(child: 18.verticalSpace),
          ],
        );
      },
    );
  }
}
