import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRatingFilterItem extends StatelessWidget {
  final int rating;
  final int selectedRating;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final TextStyle selectedTextStyle;
  final TextStyle unselectedTextStyle;
  final double horizontalPadding;
  final double verticalPadding;

  const CustomRatingFilterItem({
    super.key,
    required this.rating,
    required this.selectedRating,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedTextStyle,
    required this.unselectedTextStyle,
    this.horizontalPadding = 14,
    this.verticalPadding = 6,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = rating == selectedRating;

    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(40.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.w,
            vertical: verticalPadding.h,
          ),
          decoration: BoxDecoration(
            color: isSelected ? selectedColor : unselectedColor,
            border: Border.all(color: selectedColor),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Row(
            children: [
              Text(
                rating.toString(),
                style: isSelected ? selectedTextStyle : unselectedTextStyle,
              ),
              4.horizontalSpace,
              Icon(
                Icons.star,
                size: 18.sp,
                color: isSelected ? Colors.white : selectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}