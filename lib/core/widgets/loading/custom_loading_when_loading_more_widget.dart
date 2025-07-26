import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingWhenLoadingMoreWidget extends StatelessWidget {
  const CustomLoadingWhenLoadingMoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            'assets/animations/loading_animation.json',
            width: 45.w,
            height: 45.h,
            fit: BoxFit.scaleDown,
          ),
          18.verticalSpace,
        ],
      ),
    );
  }
}
