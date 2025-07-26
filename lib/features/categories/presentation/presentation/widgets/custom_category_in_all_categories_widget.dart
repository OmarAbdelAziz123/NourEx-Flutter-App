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
        spacing: 12.h,
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


/// In Home Screen

