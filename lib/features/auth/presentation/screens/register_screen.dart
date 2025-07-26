import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_in_leading_in_app_bar_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/register_form_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
          child: RegisterFormWidget(),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is RegisterSuccessState) {
            context.pushNamed(
              Routes.verificationScreen,
              arguments: {
                'screenName': Routes.registerScreen,
                'emailAddress': authCubit.emailController.text,
              },
            );
          }
        },
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();

          return CustomBottomNavBarHaveButtonsWidget(
            haveText: true,
            buttonTitle: 'next'.tr(),
            widgetUpOfButton: CustomRichText(
              text1: 'haveAccount'.tr(),
              text2: 'login'.tr(),
              textStyle1: Styles.contentRegular.copyWith(
                color: AppColors.neutralColor300,
              ),
              textStyle2: Styles.contentEmphasis.copyWith(
                color: AppColors.secondaryColor500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.secondaryColor500,
                decorationThickness: 1.w,
              ),
            ),
            onPressed: () {
              if (authCubit.formKey.currentState!.validate()) {
                debugPrint('Name: ${authCubit.userNameController.text}');
                debugPrint('Email: ${authCubit.emailController.text}');
                debugPrint('Phone: ${authCubit.phoneController.text}');
                authCubit.register();
                /// TODO: navigate to verification screen Success
                // context.pushNamed(
                //   Routes.verificationScreen,
                //   arguments: {
                //     'screenName': Routes.registerScreen,
                //     'emailAddress': authCubit.emailController.text,
                //   },
                // );
              } else {
                // Show validation errors
              }
            },
          );
        },
      ),
    );
  }
}
