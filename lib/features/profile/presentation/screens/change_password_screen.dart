import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';
import 'package:nourex/features/profile/presentation/widgets/change_password_form_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'تغير كلمة السر',
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ChangePasswordFormWidget()],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final profileCubit = context.read<ProfileCubit>();

          return CustomBottomNavBarHaveButtonsWidget(
            haveText: false,
            buttonTitle: 'حفظ',
            onPressed: () {
              if(profileCubit.formKey.currentState!.validate()){
                print(profileCubit.passwordController.text);
                print(profileCubit.newPasswordController.text);
                print(profileCubit.confirmNewPasswordController.text);
              }
            },
          );
        },
      ),
    );
  }
}

