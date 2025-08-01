import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:nourex/features/auth/presentation/widgets/accept_terms_and_conditions_widget.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen:
          (previous, current) =>
              current is UserTogglePasswordState ||
              current is UserToggle2PasswordState ||
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
                  'register'.tr(),
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
                  'enterEmail'.tr(),
                  style: Styles.contentRegular.copyWith(
                    height: 2.h,
                    color: AppColors.neutralColor600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              32.verticalSpace,

              /// User Name
              Text('username'.tr(), style: Styles.highlightEmphasis),
              16.verticalSpace,
              CustomTextFormFieldWidget(
                controller: authCubit.userNameController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'enterUsername'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (userName) => AppValidator.validateUsername(userName),
              ),
              18.verticalSpace,

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

              /// Phone Number Field
              Text('phoneNumber'.tr(), style: Styles.highlightEmphasis),
              16.verticalSpace,
              CustomTextFormFieldWidget(
                controller: authCubit.phoneController,
                keyboardType: TextInputType.phone,
                hintText: 'enterPhoneNumber2'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (phone) => AppValidator.validateSyrianPhoneNumber(phone),
              ),
              8.verticalSpace,

              AcceptTermsAndConditionsWidget(),
              8.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
