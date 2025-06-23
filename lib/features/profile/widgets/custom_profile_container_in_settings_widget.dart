import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/features/profile/screens/profile_screen.dart';
import 'package:nourex/features/profile/widgets/custom_arrow_in_containers_widget.dart';

class CustomProfileContainerInSettingsWidget extends StatelessWidget {
  const CustomProfileContainerInSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius + 4.r,
        ),
        border: Border.all(
          width: 1.w,
          color: AppColors.neutralColor300,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 12.w,
            children: [
              CacheNetworkImagesWidget(
                image: 'assets/pngs/profile_image.png',
                borderRadius: AppConstants.borderRadius,
                boxFit: BoxFit.scaleDown,
                width: 54.w,
                height: 54.h,
              ),
              Column(
                spacing: 2.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عمر عبدالعزيز محمد',
                    style: Styles.highlightEmphasis,
                  ),
                  Text(
                    '3omarabdelaziz123@gmail.com',
                    style: Styles.captionEmphasis.copyWith(
                      color: AppColors.neutralColor600,
                    ),
                  )
                ],
              ),
            ],
          ),
          CustomArrowInContainersWidget(),
        ],
      ),
    );
  }
}