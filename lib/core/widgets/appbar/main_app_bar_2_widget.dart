import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class MainAppBar2Widget extends StatelessWidget {
  const MainAppBar2Widget({
    super.key,
    required this.title,
    required this.onTapSearch,
    required this.onTapNotification,
  });

  final String title;
  final VoidCallback onTapSearch;
  final VoidCallback onTapNotification;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor700,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 74.h,
        leadingWidth: 70.w,
        leading: Container(
          padding: EdgeInsets.only(right: 18.w),
          child: InkWell(
            onTap: onTapSearch,
            child: SvgPicture.asset(
              'assets/svgs/search_icon.svg',
              width: 50.w,
              height: 50.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: Styles.featureEmphasis.copyWith(
            color: AppColors.neutralColor100,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
            ),
            child: InkWell(
              onTap: onTapNotification,
              child: SvgPicture.asset(
                'assets/svgs/notification_icon.svg',
                width: 50.w,
                height: 50.h,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
