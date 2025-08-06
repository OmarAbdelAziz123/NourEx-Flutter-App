import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/banners/business_logic/banners_cubit.dart';
import 'package:nourex/features/banners/presentation/widgets/banner_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllBannersScreen extends StatelessWidget {
  const AllBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(74.h),
          child: MainAppBar2Widget(
            title: 'specialOffers'.tr(),
            isSubScreen: true,
            onTapBack: () {
              context.pop();
            },
            onTapSearch: () {},
          ),
        ),
        // body: SingleChildScrollView(
        //   padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        //   child: Column(
        //     children: [
        //       ListView.separated(
        //         shrinkWrap: true,
        //         padding: EdgeInsets.zero,
        //         physics: const NeverScrollableScrollPhysics(),
        //         itemBuilder: (context, index) {
        //           return CacheNetworkImagesWidget(
        //             image: banners[index],
        //             boxFit: BoxFit.fill,
        //             borderRadius: AppConstants.borderRadius + 4.r,
        //           );
        //         },
        //         separatorBuilder: (context, index) {
        //           return 12.verticalSpace;
        //         },
        //         itemCount: banners.length,
        //       ),
        //
        //       24.verticalSpace,
        //     ],
        //   ),
        // ),
        body: BlocBuilder<BannersCubit, BannersState>(
          buildWhen: (previous, current) =>
              current is GetAllBannersLoadingState ||
              current is GetAllBannersSuccessState ||
              current is GetAllBannersErrorState ||
              current is GetAllBannersPaginationLoadingState,
          builder: (context, state) {
            final cubit = context.read<BannersCubit>();
            final bannersList = cubit.allBanners;

            return CustomRefreshIndicatorWidget(
              controller: cubit.scrollController,
              refreshIndicatorKey: cubit.refreshIndicatorKey,
              onRefresh: () => cubit.getInitialBanners(),
              slivers: [
                /// 🔄 Loading State
                if (bannersList.isEmpty && state is GetAllBannersLoadingState)
                  SliverPadding(
                    padding:
                        EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                    sliver: SliverList.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) => 16.verticalSpace,
                      itemBuilder: (context, index) => Skeletonizer(
                        enabled: true,
                        child: CacheNetworkImagesWidget(
                          image: 'assets/pngs/banner1.png',
                          boxFit: BoxFit.fill,
                          borderRadius: AppConstants.borderRadius + 4.r,
                        ),
                      ), // ⬅️ Create this
                    ),
                  )

                /// 🚫 Empty State
                else if (bannersList.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text('noBanners'.tr()),
                      ),
                    ),
                  )

                /// ✅ Loaded State
                else ...[
                  SliverPadding(
                    padding:
                        EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
                    sliver: SliverList.separated(
                      itemCount: bannersList.length,
                      separatorBuilder: (context, index) => 16.verticalSpace,
                      itemBuilder: (context, index) {
                        final banner = bannersList[index];
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              Routes.productDetailsScreen,
                              arguments: banner.product?.id,
                            );
                          },
                          child: CacheNetworkImagesWidget(
                            image: banner.image!,
                            boxFit: BoxFit.fill,
                            borderRadius: AppConstants.borderRadius + 4.r,
                          ),
                        ); // ⬅️ Create this
                      },
                    ),
                  ),

                  /// ⏳ Pagination Loading
                  if (state is GetAllBannersPaginationLoadingState)
                    SliverToBoxAdapter(
                      child: CustomLoadingWhenLoadingMoreWidget(),
                    ),
                ],

                /// 🔽 Bottom Padding
                SliverToBoxAdapter(child: 18.verticalSpace),
              ],
            );
          },
        ));
  }
}
