import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class TotalRateWidget extends StatelessWidget {
  const TotalRateWidget({
    super.key, required this.rate,
  });

  final String rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: AppColors.yellowColor100,
          size: 20.sp,
        ),
        SizedBox(width: 2.w),
        Text(
          rate,
          style: Styles.contentEmphasis.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
