import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/features/profile/presentation/widgets/custom_arrow_in_containers_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomAddressesContainerSkeletonizerWidget extends StatelessWidget {
  const CustomAddressesContainerSkeletonizerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: AppColors.neutralColor300),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No Name',
                  style: Styles.highlightSemiBold.copyWith(),
                ),
                Text(
                  'No City - No Zone - No Street',
                  style: Styles.captionRegular.copyWith(
                    color: AppColors.neutralColor600,
                  ),
                ),
              ],
            ),

            Row(
              spacing: 4.w,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: AppColors.redColor100),
                ),
                CustomArrowInContainersWidget(
                  iconColor: AppColors.primaryColor700,
                ),
                4.horizontalSpace,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
