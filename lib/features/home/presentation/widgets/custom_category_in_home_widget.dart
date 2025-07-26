import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class CustomCategoryInHomeWidget extends StatelessWidget {
  const CustomCategoryInHomeWidget(
      {super.key, required this.imageUrl, required this.categoryName});

  final String imageUrl;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
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