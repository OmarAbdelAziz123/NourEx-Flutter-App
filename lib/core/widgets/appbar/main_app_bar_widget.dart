import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nourex/core/cache_helper/cache_helper.dart';
import 'package:nourex/core/cache_helper/cache_keys.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/app_bar_widget.dart';
import 'package:nourex/core/widgets/button/back_button_widget.dart';

class MainAppBarWidget extends StatelessWidget {
  const MainAppBarWidget({
    super.key,
    this.haveNotificationIcon = true,
    this.haveSearchIcon = true,
    this.isInHome = true,
  });

  final bool? haveNotificationIcon;
  final bool? haveSearchIcon;
  final bool? isInHome;

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(
      rowWidget: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 18.w
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 1.8,
              child: Row(
                children: [
                  isInHome == true
                  ? CacheHelper.getData(key: CacheKeys.userImage) == null
                      ? Image.asset(
                          'assets/pngs/nourex_logo.png',
                          height: 66.h,
                          width: 66.w,
                        )
                      : Container(
                          width: 66.w,
                          height: 66.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                AppConstants.borderRadius / 2),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                CacheHelper.getData(key: CacheKeys.userImage) ??
                                    '',
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        )
                  : BackButtonWidget(),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      spacing: 4.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CacheHelper.getSecuredString(key: CacheKeys.userToken) == null
                              ? 'welcome'.tr()
                              : 'haveANiceDay'.tr(),
                          style: Styles.contentEmphasis.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                        ),
                        Text(
                          CacheHelper.getData(key: CacheKeys.userName) ??
                              "appName".tr(),
                          style: Styles.heading3.copyWith(
                            color: AppColors.neutralColor100,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if(haveSearchIcon == true)
              InkWell(
              onTap: () {
                context.pushNamed(Routes.searchScreen);
              },
              child: SvgPicture.asset(
                'assets/svgs/search_icon.svg',
                width: 50.w,
                height: 50.h,
              ),
            ),
            if(haveNotificationIcon == true)
              InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/svgs/notification_icon.svg',
                width: 50.w,
                height: 50.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
