import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_have_buttons_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';

class SupportDetailsScreen extends StatelessWidget {
  const SupportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: '#TICKET-12987',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 18.h,
          left: 18.w,
          right: 18.w,
          bottom: 34.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('تم الحل', style: Styles.highlightEmphasis,),
                  24.verticalSpace,
                ],
              ),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomBottomNavBarHaveButtonsWidget(
                  haveText: false,
                  buttonTitle: 'تم حل المشكلة',
                  onPressed: () {},
                ),

                Row(
                  spacing: 12.w,
                  children: [
                    Expanded(
                      child: CustomTextFormFieldWidget(
                        hintText: 'الرساله',
                        hintStyle: Styles.contentEmphasis,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/svgs/gallery_icon.svg',
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/svgs/send_icon.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}