import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/container/full_screen_image_viewer_container_widget.dart';

class SelectedImageItemContainerWidget extends StatelessWidget {
  final XFile image;
  final VoidCallback? onRemove;

  const SelectedImageItemContainerWidget({
    super.key,
    required this.image,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: AppColors.neutralColor200, width: 1.w),
      ),
      child: Stack(
        children: [
          /// Image
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            child: Image.file(
              File(image.path),
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100.w,
                  height: 100.h,
                  color: AppColors.neutralColor100,
                  child: Icon(
                    Icons.broken_image,
                    color: AppColors.neutralColor400,
                    size: 32.w,
                  ),
                );
              },
            ),
          ),

          /// View image overlay
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => FullScreenImageViewerContainerWidget(image: image),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: Icon(
                        Iconsax.eye,
                        color: Colors.white,
                        size: 20.w,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// Remove button (optional)
          if (onRemove != null)
            Positioned(
              top: 4.h,
              right: 4.w,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.redColor200,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 16.w),
                ),
              ),
            ),
        ],
      ),
    );
  }
}