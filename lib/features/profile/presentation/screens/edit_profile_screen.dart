import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'ملفي الشخصي',
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 45.r,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: CacheNetworkImagesWidget(
                                image: 'assets/pngs/profile_image2.png',
                                borderRadius: AppConstants.borderRadius,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: SvgPicture.asset(
                              'assets/svgs/camera_icon_in_profile.svg',
                              width: 20.w,
                              height: 20.h,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),

                      10.verticalSpace,
                      Text(
                        'محمد علي',
                        style: Styles.featureEmphasis,
                      ),
                      8.verticalSpace,
                    ],
                  ),
                ],
              ),
              16.verticalSpace,
              Text('الاسم', style: Styles.contentEmphasis),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: TextEditingController(),
                keyboardType: TextInputType.name,
                backgroundColor: Colors.white,
                validator: (value) {},
                hintText: 'محمد علي',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              16.verticalSpace,
              Text('البريد الالكتروني', style: Styles.contentEmphasis),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: TextEditingController(),
                backgroundColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {},
                hintText: 'mohamedali@eg.com',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              16.verticalSpace,
              Text('رقم الجوال', style: Styles.contentEmphasis),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: TextEditingController(),
                backgroundColor: Colors.white,
                keyboardType: TextInputType.phone,
                validator: (value) {},
                hintText: '01012345678',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              16.verticalSpace,
              Text('العمر', style: Styles.contentEmphasis),
              8.verticalSpace,
              CustomTextFormFieldWidget(
                controller: TextEditingController(),
                backgroundColor: Colors.white,
                keyboardType: TextInputType.number,
                validator: (value) {},
                hintText: '25',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'تعديل',
        onPressed: () {},
      ),
    );
  }
}
