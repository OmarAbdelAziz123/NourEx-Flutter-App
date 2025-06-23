import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';

class CustomArrowInContainersWidget extends StatelessWidget {
  const CustomArrowInContainersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      size: 18.sp,
      color: AppColors.neutralColor1000,
    );
  }
}
