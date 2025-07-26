import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewItemSkeletonizerWidget extends StatelessWidget {
  final bool isArabic;

  const ReviewItemSkeletonizerWidget({super.key, this.isArabic = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: isArabic ? 0.w : 16.w,
                  right: isArabic ? 16.w : 0.w,
                ),
                child: Row(
                  spacing: 16.w,
                  children: [
                    CacheNetworkImagesWidget(
                      image: 'assets/pngs/profile_image.png',
                      borderRadius: 4.r,
                      boxFit: BoxFit.fill,
                      width: 48.w,
                      height: 48.w,
                    ),
                    Text('Name here', style: Styles.contentEmphasis),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                  left: isArabic ? 0.w : 16.w,
                  right: isArabic ? 16.w : 0.w,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.neutralColor200),
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '2.5',
                            style: Styles.contentEmphasis.copyWith(
                              color: AppColors.primaryColor700,
                            ),
                          ),
                          4.horizontalSpace,
                          Icon(
                            Icons.star,
                            size: 18.sp,
                            color: AppColors.primaryColor700,
                          ),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Iconsax.more)),
                  ],
                ),
              ),
            ],
          ),

          /// Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: const CustomDividerInBottomSheet(),
          ),

          /// Review Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              'الخدمة كانت رائعة جدًا! مقدم الخدمة محترف ووصل في الوقت المحدد. أنصح الجميع بالتعامل معه. شكرًا لتطبيق حرفة على التجربة الممتازة',
              style: Styles.contentEmphasis.copyWith(height: 1.4.h),
            ),
          ),

          /// Time Ago
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              'منذ 6 ساعات',
              style: Styles.contentEmphasis.copyWith(
                color: AppColors.neutralColor600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}