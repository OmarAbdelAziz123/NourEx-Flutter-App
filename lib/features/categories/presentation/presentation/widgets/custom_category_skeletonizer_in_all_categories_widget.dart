import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCategoryInAllCategoriesSkeletonizerWidget extends StatelessWidget {
  const CustomCategoryInAllCategoriesSkeletonizerWidget({super.key});

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
          spacing: 12.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Skeleton for image
            CacheNetworkImagesWidget(
              image: 'assets/pngs/clothes_man.png',
              boxFit: BoxFit.fill,
              width: 110.w,
              height: 110.h,
              haveBorder: false,
              borderRadius: AppConstants.borderRadius,
            ),
            // 12.verticalSpace,

            /// Skeleton for text
            Container(
              width: 80.w,
              height: 14.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Text(
                'ملابس رجالية',
                style: Styles.captionBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}