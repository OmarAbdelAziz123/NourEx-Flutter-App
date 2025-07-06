import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/profile/business_logic/profile_cubit.dart';

class ChangePasswordFormWidget extends StatelessWidget {
  const ChangePasswordFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profileCubit = context.read<ProfileCubit>();

        return Form(
          key: profileCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Password Field
              Text(
                'كلمة المرور الحالية',
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                obscureText: profileCubit.isObscure,
                controller: profileCubit.passwordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'كلمة المرور الحالية',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                backgroundColor: Colors.white,
                suffixIcon: IconButton(
                  onPressed: () => profileCubit.userToggleObscure(),
                  icon: Icon(
                    profileCubit.isObscure ? Iconsax.eye_slash : Iconsax.eye,
                    size: 22.sp,
                    color: AppColors.neutralColor600,
                  ),
                ),
                validator: (password) => AppValidator.validatePassword(password),
              ),
              16.verticalSpace,

              /// New Password Field
              Text(
                'كلمة المرور الجديدة',
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                obscureText: profileCubit.isObscure2,
                controller: profileCubit.newPasswordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'كلمة المرور الجديدة',
                backgroundColor: Colors.white,
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                suffixIcon: IconButton(
                  onPressed: () => profileCubit.userToggle2Obscure(),
                  icon: Icon(
                    profileCubit.isObscure2 ? Iconsax.eye_slash : Iconsax.eye,
                    size: 22.sp,
                    color: AppColors.neutralColor600,
                  ),
                ),
                validator:
                    (password) => AppValidator.validateNewPassword(password),
              ),
              16.verticalSpace,

              /// Confirm New Password Field
              Text(
                'تأكيد كلمة المرور الجديدة',
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                obscureText: profileCubit.isObscure3,
                controller: profileCubit.confirmNewPasswordController,
                keyboardType: TextInputType.visiblePassword,
                hintText: 'قم بتأكيد كلمة المرور الخاصه بك',
                backgroundColor: Colors.white,
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                suffixIcon: IconButton(
                  onPressed: () => profileCubit.userToggle3Obscure(),
                  icon: Icon(
                    profileCubit.isObscure3 ? Iconsax.eye_slash : Iconsax.eye,
                    size: 22.sp,
                    color: AppColors.neutralColor600,
                  ),
                ),
                validator:
                    (password) => AppValidator.validateConfirmNewPassword(
                  password,
                  profileCubit.newPasswordController.text,
                ),
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
