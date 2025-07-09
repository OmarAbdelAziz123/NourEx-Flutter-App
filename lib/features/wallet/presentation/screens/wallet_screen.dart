import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:nourex/features/wallet/business_logic/wallet_cubit.dart';
import 'package:nourex/features/wallet/presentation/widgets/my_balance_widget.dart';
import 'package:nourex/features/wallet/presentation/widgets/my_points_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'محفظتي',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocProvider(
        create: (context) => WalletCubit(),
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            final cubit = context.read<WalletCubit>();

            return Column(
              children: [
                CustomTabBarWidget(
                  tabs: const ['نقاطي', 'رصيدي'],
                  selectedIndex: cubit.selectedTabIndex,
                  onTabChanged: (index) {
                    cubit.changeTab(index);
                  },
                ),

                Expanded(child: _buildTabContent(cubit.selectedTabIndex)),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'تحويل النقاط الى رصيد',
        onPressed: () {},
      ),
    );
  }

  Widget _buildTabContent(currentTabIndex) {
    switch (currentTabIndex) {
      case 0:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: MyBalanceWidget(),
        );
      case 1:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: MyPointsWidget(),
        );
      default:
        return Container();
    }
  }
}
