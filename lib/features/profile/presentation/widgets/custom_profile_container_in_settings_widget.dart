import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_arrow_in_containers_widget.dart';

class CustomProfileContainerWidget extends StatelessWidget {
  final String name;
  final String email;
  final String imagePath;

  const CustomProfileContainerWidget({
    super.key,
    required this.name,
    required this.email,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.r),
        border: Border.all(width: 1.w, color: AppColors.neutralColor300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// Profile Image
              CacheNetworkImagesWidget(
                image: imagePath,
                borderRadius: AppConstants.borderRadius,
                boxFit: BoxFit.scaleDown,
                width: 54.w,
                height: 54.h,
              ),
              SizedBox(width: 12.w),

              /// Name and Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: Styles.highlightEmphasis),
                  Text(
                    email,
                    style: Styles.captionEmphasis.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// Arrow Icon
          const CustomArrowInContainersWidget(),
        ],
      ),
    );
  }
}
