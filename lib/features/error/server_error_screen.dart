import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';

class ServerErrorScreen extends StatelessWidget {
  const ServerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Top section with spacing
              SizedBox(height: 60.h),

              // Main content area
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Server error icon
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 60.sp,
                        color: Colors.red,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Main title
                    Text(
                      'serverError'.tr(),
                      style: Styles.heading1,
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16.h),

                    // Description
                    Text(
                      'serverErrorDescription'.tr(),
                      style: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor600 ?? Colors.grey[600],
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 48.h),

                    Column(
                      spacing: 16.h,
                      children: [
                        CustomButtonWidget(
                          onPressed: () {
                            context.pushNamedAndRemoveUntil(Routes.mainLayoutScreen, arguments: 0);
                            // context.pop();
                          },
                          color: AppColors.redColor100,
                          text: 'tryAgain'.tr(),
                          textStyle: Styles.highlightBold.copyWith(color: Colors.white),
                        ),

                        CustomButtonWidget(
                          onPressed: () {
                            context.pushNamedAndRemoveUntil(Routes.loginScreen);
                          },
                          color: Colors.white,
                          borderSide: BorderSide(
                            color: AppColors.primaryColor700 ?? Colors.green,
                            width: 1.w,
                          ),
                          text: 'goToLogin'.tr(),
                          textStyle: Styles.highlightBold.copyWith(
                            color: AppColors.primaryColor700 ?? Colors.green,
                          ),
                        ),

                        // Optional: Contact support button
                        CustomButtonWidget(
                          onPressed: () {
                            _showContactDialog(context);
                          },
                          color: Colors.transparent,
                          text: 'contactSupports'.tr(),
                          textStyle: Styles.highlightBold.copyWith(
                            color: AppColors.neutralColor600 ?? Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.neutralColor100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'contactSupports'.tr(),
          style: Styles.heading4,
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'contact'.tr(),
              style: Styles.contentRegular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            _buildContactOption(
              icon: Icons.email_outlined,
              title: 'eAddress'.tr(),
              subtitle: 'nour.noorex@gmail.com',
              onTap: () {
                // Handle email contact
              },
            ),
            SizedBox(height: 12.h),
            _buildContactOption(
              icon: Icons.phone_outlined,
              title: 'pNumber'.tr(),
              subtitle: '+963 997 485 516',
              onTap: () {
                // Handle phone contact
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'close'.tr(),
              style: Styles.highlightSemiBold.copyWith(
                color: AppColors.primaryColor700 ?? Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor700 ?? Colors.green,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Styles.contentSemiBold,
                ),
                Text(
                  subtitle,
                  style: Styles.captionRegular.copyWith(
                    color: AppColors.neutralColor600 ?? Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}