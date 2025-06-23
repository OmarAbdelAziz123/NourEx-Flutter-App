import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// In Category Screen
class CustomCategoryInAllCategoriesWidget extends StatelessWidget {
  final String imageUrl;
  final String categoryName;

  const CustomCategoryInAllCategoriesWidget({
    super.key,
    required this.imageUrl,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Category Image
          CacheNetworkImagesWidget(
            image: imageUrl,
            boxFit: BoxFit.fill,
            width: 110.w,
            height: 110.h,
            haveBorder: false,
            borderRadius: AppConstants.borderRadius,
          ),
          12.verticalSpace,

          /// Category Name
          Text(
            categoryName,
            style: Styles.captionBold.copyWith(
              color: AppColors.neutralColor1000,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Skeleton for image
            Container(
              width: 110.w,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: CacheNetworkImagesWidget(
                image: 'assets/pngs/clothes_man.png',
                boxFit: BoxFit.fill,
              ),
            ),
            12.verticalSpace,

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

/// In Home Screen
class CustomCategoryInHomeWidget extends StatelessWidget {
  const CustomCategoryInHomeWidget(
      {super.key, required this.imageUrl, required this.categoryName});

  final String imageUrl;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Category Image
          CacheNetworkImagesWidget(
            image: imageUrl,
            boxFit: BoxFit.fill,
            width: 76.w,
            height: 76.h,
            haveBorder: false,
            borderRadius: AppConstants.borderRadius,
          ),
          12.verticalSpace,

          /// Category Name
          Text(
            categoryName,
            style: Styles.captionBold.copyWith(
              color: AppColors.neutralColor1000,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class CustomCategoryInHomeSkeletonizerWidget extends StatelessWidget {
  const CustomCategoryInHomeSkeletonizerWidget({super.key});

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
