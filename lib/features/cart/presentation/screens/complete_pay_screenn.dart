import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';
import 'package:nourex/features/cart/presentation/widgets/toggle_payment_methods_widget.dart';

class CompletePayScreen extends StatelessWidget {
  const CompletePayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'cart'.tr(),
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
                      'totalPrice2'.tr(),
                      style: Styles.highlightEmphasis.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    Text('565 ${'currency'.tr()}', style: Styles.heading4),
                  ],
                ),
              ),
              18.verticalSpace,

              /// Discount
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
                      "discount".tr(),
                      style: Styles.highlightEmphasis.copyWith(
                        color: AppColors.redColor100,
                      ),
                    ),
                    Text(
                      '565 ${'currency'.tr()}',
                      style: Styles.highlightEmphasis.copyWith(
                        color: AppColors.redColor100,
                      ),
                    ),
                  ],
                ),
              ),
              18.verticalSpace,

              /// Price After Discount
              /// Not Exist
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
                      'priceAfterDiscount'.tr(),
                      style: Styles.highlightEmphasis.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                    ),
                    Text('565 ${'currency'.tr()}', style: Styles.highlightEmphasis),
                  ],
                ),
              ),
              18.verticalSpace,
              Row(
                spacing: 12.w,
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomTextFormFieldWidget(
                      controller: TextEditingController(),
                      backgroundColor: AppColors.neutralColor100,
                      textInputAction: TextInputAction.done,
                      hintText: 'discountCode'.tr(),
                      hintStyle: Styles.captionRegular.copyWith(
                        color: AppColors.neutralColor600,
                      ),
                      prefixIcon: SvgPicture.asset(
                        'assets/svgs/discount.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomButtonWidget(
                      text: 'activate'.tr(),
                      color: AppColors.primaryColor700,
                    ),
                  ),
                ],
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
                          Text('address'.tr(), style: Styles.highlightSemiBold),
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
                    ),
                  ],
                ),
              ),
              12.verticalSpace,

              // /// Add Address
              // CustomButtonWidget(
              //   text: 'addAddress'.tr(),
              //   color: AppColors.neutralColor100,
              //   textStyle: Styles.contentEmphasis.copyWith(
              //     color: AppColors.primaryColor700,
              //   ),
              //   borderRadius: AppConstants.borderRadius,
              //   borderSide: BorderSide(
              //     width: 1.w,
              //     color: AppColors.primaryColor700,
              //   ),
              //   onPressed: () {},
              // ),
              // 18.verticalSpace,

              Text('notesInOrder'.tr(), style: Styles.highlightEmphasis),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'notesInOrderDescription'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              18.verticalSpace,

              TogglePaymentMethodsWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'buyNow'.tr(),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return CustomSharedShowBottomSheet(
                headingName: '${'orderNumber'.tr()} #12345',
                imagePath: 'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                text1: 'orderNumberDescription'.tr(),
                text2: 'accountCreatedSuccess'.tr(),
                description: 'orderNumberDescription2'.tr(),
                haveOneButton: false,
                haveTextSpan: true,
                buttonText1: 'next'.tr(),
                buttonText2: 'myOrders'.tr(),
              );
            },
          );
        },
      ),
    );
  }
}
