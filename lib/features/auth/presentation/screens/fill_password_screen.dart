import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/button/custom_button_in_leading_in_app_bar_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/fill_password_form_widget.dart';

class FillPasswordScreen extends StatelessWidget {
  const FillPasswordScreen({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: CustomButtonInLeadingInAppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: FillPasswordFormWidget(data: data),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is SetPasswordSuccessState) {
            if(data['screenName'] == 'forgetPassword') {
              handleForgetPasswordFlow(context, authCubit);
            } else {
              handleSignUpFlow(context, authCubit);
            }
          }
        },
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();

          return CustomBottomNavBarHaveButtonsWidget(
            haveText: false,
            buttonTitle:
                data['screenName'] == 'forgetPassword'
                    ? 'confirm'.tr()
                    : 'register2'.tr(),
            onPressed: () {
              if(authCubit.formKey.currentState!.validate()) {
                authCubit.setPassword(email: data['emailAddress']);
              }
            }
          );
        },
      ),
    );
  }

  void handleForgetPasswordFlow(BuildContext context, AuthCubit authCubit) {
    if (authCubit.formKey.currentState!.validate()) {
      debugPrint('Password: ${authCubit.passwordController.text}');
      debugPrint(
        'Confirm Password: ${authCubit.confirmPasswordController.text}',
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return CustomSharedShowBottomSheet(
            headingName: 'forgetPassword'.tr(),
            imagePath: 'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
            text1: 'accountCreated'.tr(),
            text2: 'accountCreatedSuccess'.tr(),
            description:
                'accountCreatedDescription'.tr(),
            haveOneButton: true,
            haveTextSpan: true,
            buttonText1: 'login2'.tr(),
            onPressedOnOneButton: () {
              print('تسجيل الدخول');
              context.pushNamedAndRemoveUntil(Routes.loginScreen);
            },
          );
        },
      );
    }
  }

  void handleSignUpFlow(BuildContext context, AuthCubit authCubit) {
    if (authCubit.formKey.currentState!.validate()) {
      debugPrint('Password: ${authCubit.passwordController.text}');
      debugPrint(
        'Confirm Password: ${authCubit.confirmPasswordController.text}',
      );

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return CustomSharedShowBottomSheet(
            headingName: 'register'.tr(),
            imagePath: 'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
            text1: 'accountCreated'.tr(),
            text2: 'accountCreatedSuccess'.tr(),
            description:
                'loginToBuy'.tr(),
            haveOneButton: true,
            haveTextSpan: true,
            buttonText1: 'letStart'.tr(),
            onPressedOnOneButton: () {
              // print('هيا بنا');
              context.pushNamedAndRemoveUntil(Routes.loginScreen);
            },
          );
        },
      );
    } else {
      // Optional: Show validation errors
    }
  }
}
