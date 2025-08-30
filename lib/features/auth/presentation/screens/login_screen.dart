import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/networks_helper/errors/exceptions.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_in_leading_in_app_bar_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: CustomButtonInLeadingInAppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: LoginFormWidget(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              context.pushNamedAndRemoveUntil(Routes.mainLayoutScreen);
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();

            return CustomBottomNavBarHaveButtonsWidget(
              haveText: true,
              buttonTitle: 'login2'.tr(),
              widgetUpOfButton: CustomRichText(
                text1: 'doNotHaveAccount'.tr(),
                text2: 'register'.tr(),
                textStyle1: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor300,
                ),
                textStyle2: Styles.contentEmphasis.copyWith(
                  color: AppColors.secondaryColor500,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.secondaryColor500,
                  decorationThickness: 1.w,
                ),
                onTap2: () {
                  context.pushNamed(Routes.registerScreen);
                },
              ),
              onPressed: () {
                if (authCubit.formKey.currentState!.validate()) {
                  if(authCubit.showCheckIcon == false) {
                    ToastManager.showCustomToast(
                      message: 'acceptTerms'.tr(),
                      backgroundColor: AppColors.redColor200,
                    );
                  } else {
                    debugPrint('Email: ${authCubit.emailController.text}');
                    debugPrint(
                        'Password: ${authCubit.passwordController.text}');
                    authCubit.login();
                  }

                } else {
                  // Show validation errors
                }
              },
            );
          },
        ),
      ),
    );
  }
}



