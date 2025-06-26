import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';

class FillPasswordFormWidget extends StatelessWidget {
  const FillPasswordFormWidget({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
                  data['screenName'] == 'forgetPassword'
                      ? 'انشاء كلمة مرور جديدة'
                      : 'كلمة المرور',
                  style: Styles.heading1,
                  textAlign: TextAlign.center,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Text(
                    'يرجي إضافة كلمة مرور قوية للحفاظ على بياناتك',
                    style: Styles.contentRegular.copyWith(
                      height: 2.h,
                      color: AppColors.neutralColor600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              32.verticalSpace,

              /// Password field
              Text(
                data['screenName'] == 'forgetPassword'
                    ? 'كلمة المرور الجديدة'
                    : 'كلمة المرور',
                style: Styles.highlightEmphasis,
              ),
              16.verticalSpace,

              CustomTextFormFieldWidget(
                obscureText: authCubit.isObscure,
                controller: authCubit.passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText:
                    data['screenName'] == 'forgetPassword'
                        ? 'قم بإدخال كلمة المرور الجديدةالخاصة بك '
                        : 'قم بإدخال كلمة المرور الخاصة بك هنا',
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

              /// Confirm password field
              Text(
                data['screenName'] == 'forgetPassword'
                    ? 'تأكيد كلمة المرور الجديدة'
                    : 'تأكيد كلمة المرور',
                style: Styles.highlightEmphasis,
              ),
              16.verticalSpace,

              CustomTextFormFieldWidget(
                obscureText: authCubit.isObscure2,
                controller: authCubit.confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                hintText:
                    data['screenName'] == 'forgetPassword'
                        ? 'قم بإدخال تاكيد كلمة المرور الجديدة الخاصة بك هنا'
                        : 'قم بإدخال تأكيد كلمة المرور الخاصة بك هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                suffixIcon: IconButton(
                  onPressed:
                      () => context.read<AuthCubit>().userToggle2Obscure(),
                  icon: Icon(
                    authCubit.isObscure2 ? Iconsax.eye_slash : Iconsax.eye,
                    size: 22.sp,
                    color: AppColors.neutralColor600,
                  ),
                ),
                validator:
                    (password) => AppValidator.validateConfirmPassword(
                      password,
                      authCubit.passwordController.text,
                    ),
              ),
              8.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
