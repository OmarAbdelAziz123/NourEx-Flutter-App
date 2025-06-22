import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
          image: DecorationImage(
            repeat: ImageRepeat.repeat,
            image: Svg(
              'assets/svgs/container_icon_have_icon.svg',
              size: Size(50.w, 50.h),
            ),
            fit: BoxFit.scaleDown,
          )
      ),
      child: Center(
        child: BackButton(color: Colors.white,),
      ),
    );
  }
}
