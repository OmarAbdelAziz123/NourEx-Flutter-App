import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class MainAppBar2Widget extends StatelessWidget {
  const MainAppBar2Widget({
    super.key,
    required this.title,
    this.isSubScreen = false,
    this.haveOnlyNotification = false,
    this.onTapBack,
    this.onTapSearch,
    this.onTapNotification,
  });

  final bool? isSubScreen;
  final bool? haveOnlyNotification;
  final String title;
  final VoidCallback? onTapBack;
  final VoidCallback? onTapSearch;
  final VoidCallback? onTapNotification;

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
          padding: EdgeInsets.only(right: context.locale.languageCode == 'en' ? 0 : 18.w),
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: isSubScreen == true ? onTapBack : () {
              context.pushNamed(Routes.searchScreen);
            },
            child: isSubScreen == true
                ? Transform.rotate(
                    angle: context.locale.languageCode == 'en' ? 3.14159 : 0.0,
                    child: SvgPicture.asset(
                      'assets/svgs/back_button_icon.svg',
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : SvgPicture.asset(
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
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: isSubScreen == true ? onTapSearch : onTapNotification,
              child: haveOnlyNotification == true
                  ? InkWell(
                    onTap: () {
                      context.pushNamed(Routes.notificationScreen);
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/notification_icon.svg',
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.scaleDown,
                      ),
                  )
                  : isSubScreen == true
                      ? InkWell(
                        onTap: () {
                          context.pushNamed(Routes.searchScreen);
                        },
                        child: SvgPicture.asset(
                            'assets/svgs/search_icon.svg',
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.scaleDown,
                          ),
                      )
                      : InkWell(
                onTap: () {
                  context.pushNamed(Routes.notificationScreen);
                },
                        child: SvgPicture.asset(
                            'assets/svgs/notification_icon.svg',
                            width: 50.w,
                            height: 50.h,
                            fit: BoxFit.scaleDown,
                          ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
