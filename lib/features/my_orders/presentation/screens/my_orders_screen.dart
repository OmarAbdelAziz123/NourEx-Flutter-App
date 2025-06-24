import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/tab_bar/custom_tab_bar_widget.dart';
import 'package:nourex/features/my_orders/business_logic/my_orders_cubit.dart';
import 'package:nourex/features/my_orders/presentation/widgets/pending_orders_widget.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'سجل طلباتي',
          onTapSearch: () {},
          onTapNotification: () {},
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: BlocProvider(
          create: (context) => MyOrdersCubit(),
          child: BlocBuilder<MyOrdersCubit, MyOrdersState>(
            builder: (context, state) {
              final cubit = context.read<MyOrdersCubit>();
              return Column(
                children: [
                  CustomTabBarWidget(
                    tabs: const ['قيد الانتظار', 'تم التوصيل', 'ملغي'],
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
      ),
    );
  }

  Widget _buildTabContent(currentTabIndex) {
    switch (currentTabIndex) {
      case 0:
        return PendingOrdersWidget();
      case 1:
        return Center(
          child: Text(
            'تم التوصيل',
            style: Styles.captionEmphasis,
          ),
        );
      case 2:
        return Center(
          child: Text(
            'ملغي',
            style: Styles.captionEmphasis,
          ),
        );
      default:
        return Container();
    }
  }
}