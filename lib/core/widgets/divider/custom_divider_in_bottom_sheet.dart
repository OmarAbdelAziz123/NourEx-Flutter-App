import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';

class CustomDividerInBottomSheet extends StatelessWidget {
  const CustomDividerInBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: .5.h,
      thickness: .5.h,
      color: AppColors.neutralColor600,
    );
  }
}
