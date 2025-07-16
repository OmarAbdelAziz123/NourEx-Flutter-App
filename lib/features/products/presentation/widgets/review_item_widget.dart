import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';

class ReviewItemWidget extends StatelessWidget {
  final String reviewerName;
  final String profileImagePath;
  final String reviewText;
  final String timeAgo;
  final double rating;
  final bool isArabic;
  final VoidCallback? onPressedMore;

  const ReviewItemWidget({
    super.key,
    required this.reviewerName,
    required this.profileImagePath,
    required this.reviewText,
    required this.timeAgo,
    required this.rating,
    required this.onPressedMore,
    this.isArabic = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Image.asset(
                      profileImagePath,
                      width: 48.w,
                      height: 48.w,
                      fit: BoxFit.fill,
                    ),
                    Text(reviewerName, style: Styles.contentEmphasis),
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
                        border: Border.all(color: AppColors.primaryColor700),
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            rating.toString(),
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
                    IconButton(
                      onPressed: onPressedMore,
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.neutralColor600,
                      ),
                    ),
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
              reviewText,
              style: Styles.contentEmphasis.copyWith(height: 1.4.h),
            ),
          ),

          /// Time Ago
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              timeAgo,
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
