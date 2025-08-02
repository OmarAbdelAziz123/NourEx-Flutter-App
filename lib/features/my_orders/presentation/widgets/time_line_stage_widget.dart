import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class TimelineStageWidget extends StatelessWidget {
  final String stage;
  final String status;
  final String description;
  final String buttonText;
  final bool isCompleted;
  final bool inProgressColor;

  const TimelineStageWidget({
    super.key,
    required this.stage,
    required this.status,
    required this.description,
    required this.buttonText,
    required this.isCompleted,
    required this.inProgressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stage,
          style: Styles.captionRegular.copyWith(
            color: AppColors.neutralColor600,
          ),
        ),
        Text(status, style: Styles.captionEmphasis),
        Text(
          description,
          style: Styles.captionRegular.copyWith(
            color: AppColors.neutralColor600,
          ),
        ),
        4.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius - 4.r,
            ),
            color: isCompleted
                ? AppColors.greenColor10
                : inProgressColor
                    ? AppColors.yellowColor10
                    : AppColors.neutralColor100,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: Styles.footnoteRegular.copyWith(
                color: isCompleted
                    ? AppColors.greenColor200
                    : inProgressColor
                        ? AppColors.yellowColor100
                        : AppColors.neutralColor600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
