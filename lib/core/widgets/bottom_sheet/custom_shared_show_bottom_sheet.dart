import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';

class CustomSharedShowBottomSheet extends StatelessWidget {
  const CustomSharedShowBottomSheet({
    super.key,
    required this.headingName,
    required this.imagePath,
    this.title,
    required this.description,
    this.haveOneButton = false,
    this.haveTextSpan = false,
    this.text1,
    this.text2,
    this.text2Color,
    this.buttonText1,
    this.buttonText2,
    this.onPressedOnOneButton,
    this.onTap1,
    this.onTap2,
  });

  final String headingName;
  final String imagePath;
  final String? title;
  final String description;
  final bool? haveOneButton;
  final bool? haveTextSpan;
  final String? text1;
  final String? text2;
  final Color? text2Color;
  final String? buttonText1;
  final String? buttonText2;
  final VoidCallback? onPressedOnOneButton;
  final VoidCallback? onTap1;
  final VoidCallback? onTap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
      EdgeInsets.only(left: 18.w, right: 18.w, bottom: 18.h, top: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.r),
          topLeft: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            headingName,
            style: Styles.heading4.copyWith(
              color: AppColors.neutralColor1000,
            ),
          ),
          12.verticalSpace,
          CustomDividerInBottomSheet(),
          20.verticalSpace,
          SvgPicture.asset(
            imagePath,
            fit: BoxFit.scaleDown,
            height: 139.h,
            width: 139.w,
          ),
          24.verticalSpace,
          haveTextSpan == true
              ? CustomRichText(
            text1: text1,
            text2: text2,
            textStyle1: Styles.heading3.copyWith(
              color: AppColors.neutralColor1000,
            ),
            textStyle2: Styles.heading3.copyWith(
              color: text2Color ?? AppColors.primaryColor100,
            ),
          )
              : Text(
            title!,
            style: Styles.heading3.copyWith(
              color: AppColors.neutralColor1000,
            ),
            textAlign: TextAlign.center,
          ),
          8.verticalSpace,
          Text(
            description,
            style: Styles.featureStandard.copyWith(
              color: AppColors.neutralColor1000,
            ),
            textAlign: TextAlign.center,
          ),
          24.verticalSpace,
          haveOneButton == true
              ? CustomButtonWidget(
            text: buttonText1,
            onPressed: onPressedOnOneButton ?? () {},
            fontSize: 16.sp,
            color: AppColors.primaryColor700,
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
            ),
          )
              : Row(
            spacing: 18.w,
            children: [
              Expanded(
                child: CustomButtonWidget(
                  onPressed: onTap1,
                  text: buttonText1,
                  fontSize: 16.sp,
                  color: AppColors.primaryColor700,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                  ),
                ),
              ),
              Expanded(
                child: CustomButtonWidget(
                  onPressed: onTap2,
                  text: buttonText2,
                  fontSize: 16.sp,
                  color: Colors.white,
                  textColor: AppColors.primaryColor700,
                  borderSide: BorderSide(
                    width: 1.w,
                    color: AppColors.primaryColor700,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                  ),
                ),
              ),
            ],
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
