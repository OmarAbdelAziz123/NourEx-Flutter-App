import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                onTabChanged(index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: isSelected ? 1.5.w : 1.w,
                      color: isSelected
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor300,
                    ),
                  ),
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  style: Styles.highlightEmphasis.copyWith(
                    color: isSelected
                        ? AppColors.primaryColor700
                        : AppColors.neutralColor600,
                  ),
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: Styles.highlightEmphasis.copyWith(
                      color: isSelected
                          ? AppColors.primaryColor700
                          : AppColors.neutralColor600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
