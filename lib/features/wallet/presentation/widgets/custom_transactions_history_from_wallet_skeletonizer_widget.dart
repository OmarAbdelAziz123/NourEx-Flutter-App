import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomTransactionsHistoryFromWalletSkeletonizerWidget extends StatelessWidget {
  const CustomTransactionsHistoryFromWalletSkeletonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppConstants.borderRadius - 4.r,
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
              spacing: 8.w,
              children: [
                SvgPicture.asset(
                  'assets/svgs/deposit.svg',
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                    AppColors.neutralColor300,
                    BlendMode.srcIn,
                  ),
                ),
                Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'productName'.tr(),
                      style: Styles.highlightEmphasis,
                    ),
                    Text(
                      '20 يونيو 2025',
                      style: Styles.captionEmphasis,
                    )
                  ],
                )
              ],
            ),
            Text(
              '100+',
              style: Styles.highlightBold.copyWith(
                color: AppColors.greenColor200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
