import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/helper_functions/validation.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';

class ForgetPasswordFormWidget extends StatelessWidget {
  const ForgetPasswordFormWidget({super.key});

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
                  'نسيت كلمة المرور',
                  style: Styles.heading1,
                  textAlign: TextAlign.center,
                ),
              ),

              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: Text(
                    'الرجاء إدخال بريدك الإلكتروني لإرسال رمز التأكيد إليه ',
                    style: Styles.contentRegular.copyWith(
                      height: 2.h,
                      color: AppColors.neutralColor600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              32.verticalSpace,

              /// Email Address Field
              Text('البريد الإلكتروني', style: Styles.highlightEmphasis),
              16.verticalSpace,
              CustomTextFormFieldWidget(
                controller: authCubit.emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: 'قم بإدخال بريدك الإلكتروني الخاص بك هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
                validator: (email) => AppValidator.validateEmail(email),
              ),
              18.verticalSpace,

            ],
          ),
        );
      },
    );
  }
}
