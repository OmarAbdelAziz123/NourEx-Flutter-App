import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:nourex/features/support/business_logic/support_cubit.dart';
import 'package:nourex/features/support/presentation/widgets/solved_widget.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'الدعم',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocProvider(
        create: (context) => SupportCubit(),
        child: BlocBuilder<SupportCubit, SupportState>(
          builder: (context, state) {
            final cubit = context.read<SupportCubit>();

            return Column(
              children: [
                CustomTabBarWidget(
                  tabs: ['solved'.tr(), 'inProgress'.tr(), 'rejected'.tr()],
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
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
            bottom: 18.h,
          ),
          child: CustomBottomNavBarHaveButtonsWidget(
            haveText: false,
            buttonTitle: 'contactSupport'.tr(),
            onPressed: () {
              context.pushNamed(Routes.contactSupportScreenRoute);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(currentTabIndex) {
    switch (currentTabIndex) {
      case 0:
        return SolvedWidget();
      case 1:
        return Center(
          child: Text(
            'inProgress'.tr(),
            style: Styles.highlightEmphasis,
          ),
        );
      case 2:
        return Center(
          child: Text(
            'rejected'.tr(),
            style: Styles.highlightEmphasis,
          ),
        );
      default:
        return Container();
    }
  }
}