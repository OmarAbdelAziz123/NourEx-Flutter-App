import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class CustomImagePickerBottomSheetWidget extends StatelessWidget {
  const CustomImagePickerBottomSheetWidget({super.key, this.onImagePicked});

  final void Function(XFile image)? onImagePicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.neutralColor300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          20.verticalSpace,

          Text(
            'اختر مصدر الصورة',
            style: Styles.contentEmphasis.copyWith(
              color: AppColors.neutralColor900,
            ),
          ),
          24.verticalSpace,

          _buildOptionTile(
            context: context,
            icon: 'assets/svgs/camera_icon.svg',
            title: 'الكاميرا',
            subtitle: 'التقط صورة جديدة',
            onTap: () async {
              Navigator.pop(context);
              final image = await _pickImage(ImageSource.camera, context);
              if (image != null) onImagePicked?.call(image);
            },
          ),

          16.verticalSpace,

          _buildOptionTile(
            context: context,
            icon: 'assets/svgs/gallery_icon.svg',
            title: 'المعرض',
            subtitle: 'اختر من المعرض',
            onTap: () async {
              Navigator.pop(context);
              final image = await _pickImage(ImageSource.gallery, context);
              if (image != null) onImagePicked?.call(image);
            },
          ),

          24.verticalSpace,

          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      AppConstants.borderRadius),
                  side: BorderSide(
                      color: AppColors.neutralColor300, width: 1.w),
                ),
              ),
              child: Text(
                'إلغاء',
                style: Styles.highlightEmphasis.copyWith(
                  color: AppColors.neutralColor700,
                ),
              ),
            ),
          ),

          SizedBox(height: MediaQuery
              .of(context)
              .padding
              .bottom),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutralColor200, width: 1.w),
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor700.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Styles.contentEmphasis.copyWith(
                          color: AppColors.neutralColor900)),
                  4.verticalSpace,
                  Text(subtitle,
                      style: Styles.captionRegular.copyWith(
                          color: AppColors.neutralColor600)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.w,
                color: AppColors.neutralColor400),
          ],
        ),
      ),
    );
  }

  Future<XFile?> _pickImage(ImageSource source, BuildContext context) async {
    final ImagePicker _picker = ImagePicker();

    try {
      return await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء اختيار الصورة'),
          backgroundColor: AppColors.redColor200,
        ),
      );
      return null;
    }
  }
}