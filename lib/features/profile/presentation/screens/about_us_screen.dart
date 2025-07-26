import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/text/expandable_text_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'aboutUs'.tr(),
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('about'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              ExpandableTextWidget(
                text: 'ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم ابدأ في استكشاف الميزات وإدارة بياناتك بسهولة. إذا احتجت إلى أي مساعدة، لا تتردد في التواصل مع فريق الدعم',
                mainTextStyle: Styles.contentEmphasis.copyWith(
                  letterSpacing: 0.5.w,
                  height: 1.5.h,

                ),
                subTextStyles: Styles.contentEmphasis.copyWith(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
