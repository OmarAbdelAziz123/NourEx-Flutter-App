import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/loading/custom_loading_when_loading_more_widget.dart';
import 'package:nourex/core/widgets/loading/custom_refresh_indicator_widget.dart';
import 'package:nourex/features/addresses/business_logic/addresses_cubit.dart';
import 'package:nourex/features/addresses/presentation/widgets/custom_addresses_container_skeletonizer_widget.dart';
import 'package:nourex/features/addresses/presentation/widgets/custom_addresses_container_widget.dart';
import '../../../../core/widgets/appbar/main_app_bar_2_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddressesCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'addresses'.tr(),
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: BlocConsumer<AddressesCubit, AddressesState>(
        listener: (context, state) {
          if (state is DeleteAddressSuccessState) {
            cubit.getInitialAddresses();
          }
        },
        buildWhen: (previous, current) =>
        current is GetAllAddressesLoadingState ||
            current is GetAllAddressesSuccessState ||
            current is GetAllAddressesErrorState ||
            current is DeleteAddressSuccessState ||
            current is DeleteAddressLoadingState ||
            current is AddressesPaginationLoading ||
            current is DeleteAddressErrorState,
        builder: (context, state) {
          final addressesList = cubit.allAddresses;

          return CustomRefreshIndicatorWidget(
            controller: cubit.scrollController,
            refreshIndicatorKey: cubit.refreshIndicatorKey,
            onRefresh: () => cubit.getInitialAddresses(),
            slivers: [

              /// Loading state
              if (addressesList.isEmpty && state is GetAllAddressesLoadingState)
                SliverPadding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                  sliver: SliverList.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) => 16.verticalSpace,
                    itemBuilder: (context, index) =>
                        CustomAddressesContainerSkeletonizerWidget(),
                  ),
                )

              /// Empty state
              else
                if (addressesList.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text('noAddresses'.tr()),
                      ),
                    ),
                  )

                /// Loaded data
                else
                  ...[
                    SliverPadding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 0.w, vertical: 16.h),
                      sliver: SliverList.separated(
                        itemCount: addressesList.length,
                        separatorBuilder: (context, index) => 16.verticalSpace,
                        itemBuilder: (context, index) =>
                            GestureDetector(
                              onTap: () =>
                                  context
                                      .pushNamed(
                                    Routes.addressDetailsScreen,
                                    arguments: addressesList[index],
                                  )
                                      .then((value) =>
                                      cubit.getInitialAddresses()),
                              child: CustomAddressesContainerWidget(
                                onPressedDelete: () {
                                  cubit.deleteAddress(
                                    id: addressesList[index].id ?? '',
                                  );
                                },
                                addressesDataModel: addressesList[index],
                              ),
                            ),
                      ),
                    ),

                    /// Pagination loading
                    if (state is AddressesPaginationLoading)
                      SliverToBoxAdapter(
                        child: CustomLoadingWhenLoadingMoreWidget(),
                      ),
                  ],

              /// Space at bottom
              SliverToBoxAdapter(child: 18.verticalSpace),
            ],
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'addAddress'.tr(),
        isHaveSvg: false,
        onPressed: () {
          context.pushNamed(Routes.addNewAddressScreen).then((value) {
            cubit.getInitialAddresses();
          });
        },
      ),
    );
  }
}
