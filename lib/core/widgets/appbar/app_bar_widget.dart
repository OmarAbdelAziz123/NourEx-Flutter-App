import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.rowWidget,
  });

  final Widget rowWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Color Overlay
        Container(
          height: 152.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
            color: AppColors.primaryColor700,
          ),
        ),

        /// Positioned widget directly inside the Stack
        Positioned(
          right: 15.w,
          left: 15.w,
          bottom: 20.h,
          child: rowWidget,
          // child: ,
        ),
      ],
    );
  }
}
