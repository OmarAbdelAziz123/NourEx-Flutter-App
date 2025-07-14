import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';

class CustomBottomNavBarMakeButtonOnly extends StatelessWidget {
  const CustomBottomNavBarMakeButtonOnly({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
  });

  final String buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        bottom: 28.h,
        top: 18.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralColor100,
        border: Border(
          top: BorderSide(color: AppColors.neutralColor100, width: 1.w),
        ),
      ),
      child: CustomButtonWidget(
        text: buttonTitle,
        color: AppColors.primaryColor700,
        onPressed: onPressed,
        svgPic: SvgPicture.asset(
          'assets/svgs/add_to_cart_icon.svg',
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}