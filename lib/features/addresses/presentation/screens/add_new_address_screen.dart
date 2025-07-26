import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/features/addresses/business_logic/addresses_cubit.dart';
import 'package:nourex/features/addresses/presentation/widgets/add_new_address_form_widget.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'addNewAddress'.tr(),
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: AddNewAddressFormWidget(),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AddressesCubit, AddressesState>(
        listener: (context, state) {
          if(state is AddAddressSuccessState) {
            // context.pop();
          }
        },
        builder: (context, state) {
          final addressesCubit = context.read<AddressesCubit>();

          return CustomBottomNavBarMakeButtonOnly(
            buttonTitle: 'save'.tr(),
            onPressed: () {
              addressesCubit.addAddress();
            },
          );
        },
      ),
    );
  }
}
