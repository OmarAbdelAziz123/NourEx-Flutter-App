import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class CustomButtonInLeadingInAppBarWidget extends StatelessWidget {
  const CustomButtonInLeadingInAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius - 4.r),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(6.sp),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.neutralColor600,
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(
                  AppConstants.borderRadius - 4.r,
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                size: 22.sp,
                color: AppColors.neutralColor1000,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
