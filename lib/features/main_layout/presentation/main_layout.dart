import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/routing/app_router.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_cubit.dart';
import 'package:nourex/features/main_layout/bloc/main_layout_state.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, this.index = 0});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        final cubit = MainLayoutCubit.get(context);
        final currentIndex = (state is AppBottomNavState) ? state.currentIndex : index;

        return Scaffold(
          backgroundColor: Colors.white,
          body: AppRouter()
              .userScreens[currentIndex],
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: AppColors.primaryColor700,
              unselectedItemColor: AppColors.neutralColor400,
              selectedLabelStyle: Styles.captionBold,
              unselectedLabelStyle: Styles.captionEmphasis,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/home_icon.svg',
                    fit: BoxFit.scaleDown,
                    width: 24.sp,
                    height: 24.sp,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 0
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/cart_icon.svg',
                    fit: BoxFit.scaleDown,
                    width: 24.sp,
                    height: 24.sp,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 1
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'cart'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/order_icon.svg',
                    fit: BoxFit.scaleDown,
                    width: 24.sp,
                    height: 24.sp,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 2
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'orders'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svgs/settings_icon.svg',
                    width: 24.sp,
                    height: 24.sp,
                    fit: BoxFit.scaleDown,
                    colorFilter: ColorFilter.mode(
                      currentIndex == 3
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'settings'.tr(),
                ),
              ],
              onTap: (index) {
                MainLayoutCubit.get(context).changeBottomNavBar(index);
              },
            ),
          ),

        );
      },
    );
  }
}
