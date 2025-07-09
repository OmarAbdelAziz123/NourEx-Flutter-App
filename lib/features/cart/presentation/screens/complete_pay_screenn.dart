import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';

class CompletePayScreen extends StatelessWidget {
  const CompletePayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'السلة',
          isSubScreen: true,
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
              /// Total Price
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.neutralColor300,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'سعر الكلي',
                      style: Styles.highlightEmphasis.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    Text('SAR 565', style: Styles.heading4),
                  ],
                ),
              ),
              18.verticalSpace,

              /// Address
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius + 4.r,
                  ),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.primaryColor700,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'العنوان',
                            style: Styles.highlightSemiBold,
                          ),
                          Text(
                            'البلد - المدينة - اسم الشارع ',
                            style: Styles.captionRegular.copyWith(
                              color: AppColors.neutralColor600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18.sp,
                      color: AppColors.primaryColor700,
                    )
                  ],
                ),
              ),
              12.verticalSpace,

              /// Add Address
              CustomButtonWidget(
                text: 'اضافة عنوان',
                color: AppColors.neutralColor100,
                textStyle: Styles.contentEmphasis.copyWith(
                  color: AppColors.primaryColor700,
                ),
                borderRadius: AppConstants.borderRadius,
                borderSide: BorderSide(
                  width: 1.w,
                  color: AppColors.primaryColor700,
                ),
                onPressed: () {},
              ),
              18.verticalSpace,

              Text(
                'ملاحظات حول الطلب',
                style: Styles.highlightEmphasis,
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'قم بادخال ملاحظاتك حول  الطلب هنا',
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              18.verticalSpace,

              Text(
                'طريقة الدفع',
                style: Styles.featureBold,
              ),
              8.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'شراء الان',
        onPressed: () {},
      ),
    );
  }
}
