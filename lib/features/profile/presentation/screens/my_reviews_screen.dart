import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_bottom_sheet_review.dart';
import 'package:nourex/core/widgets/drop_down/custom_drop_down_menu_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_skeletonizer_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/review_item_widget.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'myReviews'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () => context.pop(),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) =>
        current is GetAllMyReviewsLoadingState ||
            current is GetAllMyReviewsSuccessState ||
            current is GetAllMyReviewsErrorState ||
            current is DeleteReviewSuccessState ||
            current is DeleteReviewLoadingState ||
            current is UpdateReviewLoadingState ||
            current is UpdateReviewErrorState ||
            current is UpdateReviewSuccessState ||
            current is MyReviewsPaginationLoading ||
            current is DeleteReviewErrorState ||
            current is UpdateProfileSuccessState,
        listener: (context, state) {
          if(state is UpdateReviewSuccessState) {
            profileCubit.getInitialMyReviews();
          }
        },
        builder: (context, state) {
          final reviews = profileCubit.allMyReviews;

          return CustomRefreshIndicatorWidget(
            controller: profileCubit.scrollController,
            refreshIndicatorKey: profileCubit.refreshIndicatorKey,
            onRefresh: () => profileCubit.getInitialMyReviews(),
            slivers: [

              /// Loading state
              if (reviews.isEmpty || state is UpdateReviewSuccessState)
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  sliver: SliverList.separated(
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                    const ReviewItemSkeletonizerWidget(),
                    separatorBuilder: (context, index) => 16.verticalSpace,
                  ),
                )

              /// Empty state
              else
                if (reviews == [])
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(
                          'noReviews'.tr(),
                          style: Styles.contentRegular,
                        ),
                      ),
                    ),
                  )

                /// Loaded data
                else ...[
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: context.locale.languageCode == 'ar' ? 0.w : 16.w),
                    sliver: SliverList.separated(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        print('review: $review');

                        return ReviewItemWidget(
                          reviewerName: review.user?.name ?? '',
                          profileImagePath: review.user?.profilePic ?? '',
                          reviewText: review.comment ?? '',
                          timeAgo: review.createdAt ?? '',
                          rating: double.tryParse(review.rating.toString()) ??
                              0.0,
                          isArabic: true,
                          moreIconButtonWidget: CustomDropDownMenuWidget(
                            onSelected: (String value) {
                              if (value == 'الابلاغ') {
                                // Navigate to report
                              } else if (value == 'تعديل التقييم') {
                                double updatedRating =
                                    double.tryParse(review.rating.toString()) ??
                                        0.0;
                                profileCubit.commentController.text =
                                    review.comment ?? '';

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return CustomSharedBottomSheetReview(
                                      title: 'التقييم',
                                      nameOfFiled: 'قيّم هذا المنتج',
                                      initialRating: updatedRating,
                                      hintText: review.comment ??
                                          'تقييمك يصنع الفرق! أخبرنا بتجربتك مع المنتج.',
                                      isEdit: false,
                                      buttonText1: 'تاكيد',
                                      buttonText2: 'الغاء',
                                      onRatingChanged: (rating) {
                                        updatedRating = rating;
                                      },
                                      commentController:
                                      profileCubit.commentController,
                                      onEditPressed: () {
                                        profileCubit.updateMyReview(
                                          productId: review.product?.id ?? '',
                                          reviewId: review.id ?? '',
                                          rating: updatedRating,
                                        );
                                        context.pop();
                                      },
                                      onCancelPressed: () =>
                                          Navigator.pop(context),
                                    );
                                  },
                                );
                              } else if (value == 'حذف التقييم') {
                                profileCubit.deleteMyReview(
                                  productId: review.user?.id ?? '',
                                  reviewId: review.id ?? '',
                                );
                              }
                            },
                            menuItems: [
                              {
                                'title': 'الابلاغ',
                                'icon': Icons.report_outlined
                              },
                              {'title': 'تعديل التقييم', 'icon': Iconsax.edit},
                              {'title': 'حذف التقييم', 'icon': Iconsax.trash},
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => 16.verticalSpace,
                    ),
                  ),

                  /// Pagination loading
                  if (state is MyReviewsPaginationLoading)
                    SliverToBoxAdapter(
                      child: CustomLoadingWhenLoadingMoreWidget(),
                    ),
                ],

              /// Add spacing
              SliverToBoxAdapter(child: 18.verticalSpace),
            ],
          );
        },
      ),
    );
  }
}


// class MyReviewsScreen extends StatelessWidget {
//   const MyReviewsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(74.h),
//         child: MainAppBar2Widget(
//           title: 'myReviews'.tr(),
//           isSubScreen: true,
//           haveOnlyNotification: false,
//           onTapBack: () {
//             context.pop();
//           },
//         ),
//       ),
//       body: BlocConsumer<ProfileCubit, ProfileState>(
//         listener: (context, state) {
//           if (state is DeleteReviewSuccessState || state is UpdateReviewSuccessState) {
//             context.read<ProfileCubit>().getInitialMyReviews();
//           }
//         },
//         builder: (context, state) {
//           final profileCubit = context.read<ProfileCubit>();
//
//           return SingleChildScrollView(
//             child: Column(
//               children: [
//                 18.verticalSpace,
//                 profileCubit.myReviewsDataModel == null ||
//                         state is GetAllMyReviewsLoadingState
//                     ? ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 5,
//                         separatorBuilder: (context, index) => 16.verticalSpace,
//                         itemBuilder: (context, index) =>
//                             const ReviewItemSkeletonizerWidget(),
//                       )
//                     : profileCubit.myReviewsDataModel!.reviews == [] ||
//                             profileCubit.myReviewsDataModel!.reviews!.isEmpty
//                         ? Center(
//                             child: Text(
//                               'noReviews'.tr(),
//                               style: Styles.contentRegular,
//                             ),
//                           )
//                         : ListView.separated(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: profileCubit
//                                 .myReviewsDataModel!.reviews!.length,
//                             separatorBuilder: (context, index) =>
//                                 16.verticalSpace,
//                             itemBuilder: (context, index) => ReviewItemWidget(
//                               reviewerName: profileCubit.myReviewsDataModel!
//                                       .reviews![index].product!.name ??
//                                   '',
//                               profileImagePath: profileCubit.myReviewsDataModel!
//                                       .reviews![index].product!.mainImageURL ??
//                                   '',
//                               reviewText: profileCubit.myReviewsDataModel!
//                                       .reviews![index].comment ??
//                                   '',
//                               timeAgo: profileCubit.myReviewsDataModel!
//                                       .reviews![index].createdAt ??
//                                   '',
//                               rating: double.parse(profileCubit
//                                       .myReviewsDataModel!
//                                       .reviews![index]
//                                       .rating
//                                       .toString()) ??
//                                   0.0,
//                               isArabic: true,
//                               moreIconButtonWidget: CustomDropDownMenuWidget(
//                                 onSelected: (String value) {
//                                   if (value == 'الابلاغ') {
//                                     print('navigate to report screen');
//                                   } else if (value == 'تعديل التقييم') {
//                                     showModalBottomSheet(
//                                       context: context,
//                                       isScrollControlled: true,
//                                       builder: (context) {
//                                         double updatedRating = double.parse(
//                                           profileCubit.myReviewsDataModel!.reviews![index].rating.toString(),
//                                         );
//
//                                         profileCubit.commentController.text =
//                                             profileCubit.myReviewsDataModel!.reviews![index].comment ?? '';
//
//                                         return CustomSharedBottomSheetReview(
//                                           title: 'التقييم',
//                                           nameOfFiled: 'قيّم هذا المنتج',
//                                           initialRating: double.parse(
//                                                   profileCubit
//                                                       .myReviewsDataModel!
//                                                       .reviews![index]
//                                                       .rating
//                                                       .toString()) ??
//                                               0.0,
//                                           hintText: profileCubit
//                                                   .myReviewsDataModel!
//                                                   .reviews![index]
//                                                   .comment ??
//                                               'تقييمك يصنع الفرق! أخبرنا بتجربتك مع المنتج.',
//                                           isEdit: false,
//                                           buttonText1: 'تاكيد',
//                                           buttonText2: 'الغاء',
//                                           onRatingChanged: (rating) {
//                                             updatedRating = rating;
//                                           },
//                                           commentController: profileCubit.commentController,
//                                           onEditPressed: () {
//                                             profileCubit.updateMyReview(
//                                               productId: profileCubit
//                                                   .myReviewsDataModel!
//                                                   .reviews![index]
//                                                   .product!
//                                                   .id ??
//                                                   '',
//                                               reviewId: profileCubit
//                                                   .myReviewsDataModel!
//                                                   .reviews![index]
//                                                   .id ??
//                                                   '',
//                                               rating: updatedRating,
//                                             );
//                                             context.pop();
//                                           },
//                                           onCancelPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                         );
//                                       },
//                                     );
//                                   } else if (value == 'حذف التقييم') {
//                                     profileCubit.deleteMyReview(
//                                       productId: profileCubit
//                                               .myReviewsDataModel!
//                                               .reviews![index]
//                                               .product!
//                                               .id ??
//                                           '',
//                                       reviewId: profileCubit.myReviewsDataModel!
//                                               .reviews![index].id ??
//                                           '',
//                                     );
//                                   }
//                                 },
//                                 menuItems: [
//                                   {
//                                     'title': 'الابلاغ',
//                                     'icon': Icons.report_outlined,
//                                   },
//                                   {
//                                     'title': 'تعديل التقييم',
//                                     'icon': Iconsax.edit
//                                   },
//                                   {
//                                     'title': 'حذف التقييم',
//                                     'icon': Iconsax.trash
//                                   },
//                                 ],
//                               ),
//                             ),
//                           ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
