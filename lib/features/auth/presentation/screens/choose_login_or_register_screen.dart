import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/services/firebase/fcm.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';

class ChooseLoginOrRegisterScreen extends StatelessWidget {
  const ChooseLoginOrRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 18.h,
            left: 18.w,
            right: 18.w,
          ),
          child: Column(
            children: [
              Text(
                'مرحبا بك في نوريكس ',
                style: Styles.heading1,
              ),
              10.verticalSpace,

              Text(
                'اختر طريقة التسجيل الخاصه بك',
                style: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              32.verticalSpace,

              Stack(
                alignment: Alignment.topCenter,
                children: [
                  /// Container with buttons and content
                  Container(
                    margin: EdgeInsets.only(top: 50.h), // To leave space for the logo
                    height: 272.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.borderRadius + 8.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.primaryColor700,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButtonWidget(
                          text: 'تسجيل دخول',
                          color: AppColors.primaryColor700,
                          textColor: AppColors.neutralColor100,
                          borderRadius: AppConstants.borderRadius,
                          onPressed: () {
                            context.pushNamed(Routes.loginScreen);
                          },
                        ),
                        18.verticalSpace,
                        CustomButtonWidget(
                          text: 'إنشاء حساب',
                          color: Colors.transparent,
                          boxShadow: [],
                          textColor: AppColors.primaryColor700,
                          borderSide: BorderSide(
                            width: 1.w,
                            color: AppColors.primaryColor700,
                          ),
                          borderRadius: AppConstants.borderRadius,
                          onPressed: () {
                            context.pushNamed(Routes.registerScreen);
                          },
                        ),
                        18.verticalSpace,
                        CustomRichText(
                          text1: 'لا أريد إنشاء حساب الأن  ',
                          text2: 'تسجيل كضيف',
                          textStyle1: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor600,
                          ),
                          textStyle2: Styles.captionEmphasis.copyWith(
                            color: AppColors.secondaryColor500,
                            decoration: TextDecoration.underline,
                          ),
                          onTap2: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return CustomSharedShowBottomSheet(
                                  headingName: 'تسجيل كضيف',
                                  imagePath:
                                  'assets/svgs/yellow_icon_in_bottom_sheet_icon.svg',
                                  title:
                                  'أهلاً بك! يمكنك إستكشاف التطبيق وتصفح المنتجات بكل حرية',
                                  description:
                                  'لن تتمكن من إتمام عمليات الشراء إلا بعد تسجيل الدخول أو إنشاء حساب.',
                                  haveOneButton: false,
                                  buttonText1: 'تسجيل الدخول',
                                  buttonText2: 'تسجيل كضيف',
                                  onTap1: () {
                                    context.pop();
                                    context.pushNamed(Routes.loginScreen);
                                  },
                                  onTap2: () {
                                    context.pop();

                                    /// TODO: Make Push And Remove Until Screen
                                    context.pushNamed(Routes.mainLayoutScreen, arguments: 0);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        18.verticalSpace,
                      ],
                    ),
                  ),

                  /// Centered top image
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      'assets/pngs/logo_in_choose_login_or_register.png',
                      fit: BoxFit.contain,
                      height: 100.h,
                      width: 100.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}