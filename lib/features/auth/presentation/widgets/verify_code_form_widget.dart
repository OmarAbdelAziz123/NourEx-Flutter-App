import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';
import 'package:nourex/features/auth/business_logic/auth_cubit.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeFormWidget extends StatelessWidget {
  const VerifyCodeFormWidget({super.key, required this.data});

  // final String emailAddress;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();

        return Form(
          key: authCubit.formKey,
          child: Column(
            children: [
              40.verticalSpace,
              Text(
                'otp'.tr(),
                style: Styles.heading1,
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      'otpDescription'.tr(),
                      style: Styles.contentRegular.copyWith(
                        height: 2.h,
                        color: AppColors.neutralColor600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      spacing: 5.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['emailAddress'],
                          style: Styles.contentRegular.copyWith(
                            height: 2.h,
                            color: AppColors.neutralColor600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/edit_email_in_verify_code.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              32.verticalSpace,

              /// Verify Code
              Center(
                child: Pinput(
                  controller: authCubit.otpController,
                  length: 4,
                  autofocus: true,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  pinAnimationType: PinAnimationType.fade,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  onChanged: (pin) {},
                  onCompleted: (pin) {
                    print('Pin entered: $pin');
                    authCubit.confirmForgetPassword(email: data['emailAddress']);
                  },
                  defaultPinTheme: PinTheme(
                    width: AppConstants.screenHeight(context) / 14,
                    height: AppConstants.screenHeight(context) / 14,
                    textStyle: Styles.contentEmphasis.copyWith(
                      color: AppColors.neutralColor1000,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.neutralColor200),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: AppConstants.screenHeight(context) / 14,
                    height: AppConstants.screenHeight(context) / 14,
                    textStyle: Styles.contentEmphasis.copyWith(
                      color: AppColors.neutralColor1000,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor900),
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderRadius,
                      ),
                    ),
                  ),
                  errorText: 'otp.validOtp'.tr(),
                  errorTextStyle: Styles.contentEmphasis.copyWith(
                    color: AppColors.redColor200,
                  ),
                ),
              ),
              18.verticalSpace,

              /// Resend Code
              CustomRichText(
                text1: 'otpDescription2'.tr(),
                textStyle1: Styles.contentRegular,
                text2: '( ${authCubit.countdown} ${'second'.tr()} ) ',
                textStyle2: Styles.contentRegular.copyWith(
                  color:
                      authCubit.canResend
                          ? AppColors.redColor100
                          : AppColors.primaryColor700,
                  fontWeight: FontWeight.bold,
                ),
                text3: authCubit.canResend ? 'resend'.tr() : '',
                textStyle3: Styles.contentRegular.copyWith(
                  color:
                      authCubit.canResend
                          ? AppColors.secondaryColor500
                          : AppColors.neutralColor300,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      authCubit.canResend
                          ? AppColors.secondaryColor500
                          : AppColors.neutralColor300,
                  decorationThickness: 2.w,
                ),
                onTap3:
                    authCubit.canResend
                        ? () {
                          authCubit.resendCode();
                        }
                        : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
