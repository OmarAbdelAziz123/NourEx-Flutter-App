import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/services/di/di.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:nourex/features/error/un_authorized_screen.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/presentation/widgets/status_orders_widget.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppConstants.userToken == null
        ? UnAuthorizedScreen()
        :   Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'orders'.tr(),
          onTapSearch: () {},
          onTapNotification: () {},
        ),
      ),
      body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
        builder: (context, state) {
          final cubit = context.read<MyOrdersCubit>();

          return Column(
            children: [
              CustomTabBarWidget(
                tabs: ['pending'.tr(), 'delivered'.tr(), 'cancelled'.tr()],
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
        return StatusOrdersWidget(
          status: 'Pending',
        );
      case 1:
        return StatusOrdersWidget(
          status: 'Delivered',
        );
      case 2:
        return StatusOrdersWidget(
          status: 'Cancelled',
        );
      default:
        return Container();
    }
  }
}
