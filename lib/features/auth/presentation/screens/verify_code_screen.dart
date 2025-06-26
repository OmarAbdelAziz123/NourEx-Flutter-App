import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/button/custom_button_in_leading_in_app_bar_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/verify_code_form_widget.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, required this.data});

  // final String emailAddress;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
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
          child: VerifyCodeFormWidget(data: data),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();

          return CustomBottomNavBarHaveButtonsWidget(
            haveText: false,
            buttonTitle: 'تأكيد',
            onPressed: () {
              if (authCubit.formKey.currentState!.validate()) {
                debugPrint('OTP: ${authCubit.otpController.text}');
                context.pushNamed(Routes.fillPasswordScreen, arguments: {
                  'screenName': data['screenName'],
                  'emailAddress': data['emailAddress'],
                });
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
