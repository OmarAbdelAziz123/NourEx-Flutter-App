import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/accept_terms_and_conditions_widget.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen:
          (previous, current) =>
              current is UserTogglePasswordState ||
              current is UserToggleCheckIconState,
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();

        return Form(
          key: authCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              40.verticalSpace,
              Center(
                child: Text(
                  'login2'.tr(),
                  style: Styles.heading1,
                  textAlign: TextAlign.center,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Text(
                  'emailDescription2'.tr(),
                  style: Styles.contentRegular.copyWith(
                    height: 2.h,
                    color: AppColors.neutralColor600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              32.verticalSpace,

              /// Email Address Field
              Text('email'.tr(), style: Styles.highlightEmphasis),
              16.verticalSpace,
              CustomTextFormFieldWidget(
                controller: authCubit.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'emailDescription'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (email) => AppValidator.validateEmail(email),
              ),
              18.verticalSpace,

              /// Password Field
              Text('password'.tr(), style: Styles.highlightEmphasis),
              16.verticalSpace,
              CustomTextFormFieldWidget(
                obscureText: authCubit.isObscure,
                controller: authCubit.passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'confirmPassword'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                suffixIcon: IconButton(
                  onPressed:
                      () => context.read<AuthCubit>().userToggleObscure(),
                  icon: Icon(
                    authCubit.isObscure ? Iconsax.eye_slash : Iconsax.eye,
                    size: 22.sp,
                    color: AppColors.neutralColor600,
                  ),
                ),
                validator:
                    (password) => AppValidator.validatePassword(password),
              ),
              8.verticalSpace,

              AcceptTermsAndConditionsWidget(),
              8.verticalSpace,

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      context.pushNamed(Routes.forgetPasswordScreen);
                    },
                    child: Text(
                      'forgetPassword?'.tr(),
                      style: Styles.contentRegular.copyWith(
                        color: AppColors.secondaryColor500,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondaryColor500,
                        decorationThickness: 1.w,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
