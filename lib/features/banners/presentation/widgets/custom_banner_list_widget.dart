import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/custom_specific_banner_widget.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';

class CustomBannerListWidget extends StatelessWidget {
  const CustomBannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Column(
      children: [
        ShowMoreRowWidget(
          title: 'specialOffers'.tr(),
          onTapShowMore: () {
            context.pushNamed(Routes.allBannersScreen);
          },
        ),
        12.verticalSpace,

        CustomSpecificBannerWidget(banners: banners),
        12.verticalSpace,

        /// Dots
        /// Dots based on HomeCubit state
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => current is ChangeIndexBanner,
          builder: (context, state) {
            int currentIndex = 0;

            if (state is ChangeIndexBanner) {
              currentIndex = state.index;
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                final isActive = index == currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 5.h,
                  width: isActive ? 16.w : 6.w,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primaryColor700
                        : AppColors.primaryColor200,
                    borderRadius: BorderRadius.circular(200.r),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}