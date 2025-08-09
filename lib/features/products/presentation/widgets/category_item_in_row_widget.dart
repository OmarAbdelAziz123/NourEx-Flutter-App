import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class CategoryItemInRowWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;
  final bool isLast;

  const CategoryItemInRowWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(
          right: isFirst ? 18.w : 0,
          left: isLast ? 18.w : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: isSelected ? AppColors.primaryColor700 : Colors.white,
          border: Border.all(color: isSelected ? AppColors.primaryColor700 : AppColors.neutralColor300, width: 1.w),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: Styles.contentEmphasis.copyWith(
            color: isSelected ? Colors.white : AppColors.neutralColor1000,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
