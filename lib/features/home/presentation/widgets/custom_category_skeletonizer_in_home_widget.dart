import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCategorySkeletonizerInHomeWidget extends StatelessWidget {
  const CustomCategorySkeletonizerInHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Skeleton for image
            Container(
              width: 76.w,
              height: 76.h,
              decoration: BoxDecoration(
                color: AppColors.neutralColor200,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
            12.verticalSpace,

            /// Skeleton for text
            Container(
              width: 40.w,
              height: 10.h,
              decoration: BoxDecoration(
                color: AppColors.neutralColor200,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
            ),
          ],
        ),
      ),
    );
  }
}