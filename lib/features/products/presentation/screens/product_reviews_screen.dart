import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/products/business_logic/products_cubit.dart';
import 'package:nourex/features/products/data/models/product_details_model.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_skeletonizer_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key, required this.productDetailsModel});

  final Result productDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'reviews'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () => context.pop(),
        ),
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = context.read<ProductsCubit>();
            final productReviews = cubit.allProductReviews;

            return CustomRefreshIndicatorWidget(
              controller: cubit.scrollController,
              refreshIndicatorKey: cubit.refreshIndicatorKey,
              onRefresh: () => cubit.getInitialProductReviews(
                productId: productDetailsModel.sId.toString(),
              ),
              slivers: [
                /// Loading State
                if (productReviews.isEmpty ||
                    state is GetProductReviewsLoadingState)
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    sliver: SliverList.separated(
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          const ReviewItemSkeletonizerWidget(),
                      separatorBuilder: (context, index) => 16.verticalSpace,
                    ),
                  )

                /// Empty States
                else if (productReviews == [])
                  SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'noReviews'.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  )

                /// Loaded data
                else ...[
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    sliver: SliverList.separated(
                      itemCount: productReviews.length,
                      itemBuilder: (context, index) {
                        final review = productReviews[index];
                        print('review: $review');

                        return BlocProvider(
                          create: (context) => ProfileCubit(getIt()),
                          child: BlocConsumer<ProfileCubit, ProfileState>(
                            listener: (context, state) {
                              final profileCubit = context.read<ProfileCubit>();

                              if(state is UpdateReviewSuccessState) {
                                profileCubit.getInitialMyReviews();
                              }
                            },
                            builder: (context, state) {
                              final profileCubit = context.read<ProfileCubit>();

                              return ReviewItemWidget(
                                reviewerName: review.user?.name ?? '',
                                profileImagePath: review.user?.profilePic ?? '',
                                reviewText: review.comment ?? '',
                                timeAgo: review.createdAt ?? '',
                                rating:
                                    double.tryParse(review.rating.toString()) ??
                                        0.0,
                                isArabic: true,
                                moreIconButtonWidget: CustomDropDownMenuWidget(
                                  onSelected: (String value) {
                                    if (value == 'report'.tr()) {
                                      profileCubit.makeReportReview(reviewId: review.id.toString());
                                    }
                                  },
                                  menuItems: [
                                    {
                                      'title': 'report'.tr(),
                                      'icon': Icons.report_outlined
                                    },
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 16.verticalSpace,
                    ),
                  ),

                  /// Pagination loading
                  if (state is ProductReviewsPaginationLoading)
                    SliverToBoxAdapter(
                      child: CustomLoadingWhenLoadingMoreWidget(),
                    ),
                ],

                /// Add spacing
                SliverToBoxAdapter(child: 18.verticalSpace),
              ],
            );
          }),
    );
  }
}
