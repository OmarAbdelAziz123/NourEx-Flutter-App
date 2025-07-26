import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_image_picker_bottom_sheet_widget.dart';
import 'package:nourex/core/widgets/bottom_sheet/custom_shared_show_bottom_sheet.dart';
import 'package:nourex/core/widgets/button/custom_button_widget.dart';
import 'package:nourex/core/widgets/container/selectd_image_item_container_widget.dart';
import 'package:nourex/core/widgets/text_field/custom_text_form_field_widget.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  List<XFile> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'returnOrder'.tr(),
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
          padding: EdgeInsets.only(
            top: 18.h,
            left: 18.w,
            right: 18.w,
            bottom: 52.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'returnOrderDescription'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                borderWidth: 1.w,
                maxLines: 5,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'returnOrderDescription2'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              24.verticalSpace,

              Text(
                'selectProduct'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              24.verticalSpace,

              Text(
                'productImage'.tr(),
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor1000,
                ),
              ),
              8.verticalSpace,

              CustomTextFormFieldWidget(
                borderRadius: AppConstants.borderRadius,
                readOnly: true,
                showCursor: false,
                onTap: () {
                  _showImagePickerBottomSheet(context);
                },
                suffixIcon: SvgPicture.asset(
                  'assets/svgs/gallery_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                borderWidth: 1.w,
                controller: TextEditingController(),
                backgroundColor: Colors.transparent,
                hintText: 'productDescription'.tr(),
                hintStyle: Styles.contentRegular.copyWith(
                  color: AppColors.neutralColor600,
                ),
              ),
              24.verticalSpace,

              /// Row Selected Images
              if (selectedImages.isNotEmpty) ...[
                Text(
                  '${'selectedImages'.tr()} (${selectedImages.length})',
                  style: Styles.highlightEmphasis.copyWith(
                    color: AppColors.neutralColor1000,
                  ),
                ),
                12.verticalSpace,
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedImages.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final image = selectedImages[index];
                      return SelectedImageItemContainerWidget(
                        image: image,
                        onRemove: () {
                          setState(() {
                            selectedImages.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
                16.verticalSpace,
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 18.w,
          right: 18.w,
          bottom: 35.h,
          top: 18.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.neutralColor100, width: 1.w),
          ),
        ),
        child: Row(
          spacing: 16.w,
          children: [
            Expanded(
              child: CustomButtonWidget(
                text: 'returnOrder'.tr(),
                color: AppColors.primaryColor700,
                onPressed: () {
                  print('Filter');
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColors.neutralColor100,
                    isScrollControlled: true,
                    builder: (context) {
                      return CustomSharedShowBottomSheet(
                        headingName: 'returnOrder'.tr(),
                        imagePath:
                            'assets/svgs/green_icon_in_bottom_sheet_icon.svg',
                        haveTextSpan: true,
                        text1: 'orderSent'.tr(),
                        text2: 'returnOrder'.tr(),
                        description: 'orderSentDescription'.tr(),
                        haveOneButton: false,
                        buttonText1: 'contactSupport'.tr(),
                        buttonText2: 'myOrders'.tr(),
                        onTap1: () {},
                        onTap2: () {},
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: CustomButtonWidget(
                text: 'cancelOrder'.tr(),
                textColor: AppColors.primaryColor700,
                borderSide: BorderSide(
                  color: AppColors.primaryColor700,
                  width: 1.w,
                ),
                borderRadius: AppConstants.borderRadius - 2.w,
                color: Colors.white,
                onPressed: () {
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  /// Add this method to show the image picker bottom sheet
  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.neutralColor100,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.borderRadius),
        ),
      ),
      builder:
          (context) => CustomImagePickerBottomSheetWidget(
            onImagePicked: (image) {
              setState(() {
                selectedImages.add(image);
              });
              print('Selected: ${image.path}');
            },
          ),
    );
  }
}