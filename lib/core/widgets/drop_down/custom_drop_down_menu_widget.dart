import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

class CustomDropDownMenuWidget extends StatelessWidget {
  final void Function(String) onSelected;
  final List<Map<String, dynamic>> menuItems;

  const CustomDropDownMenuWidget({
    super.key,
    required this.onSelected,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.borderRadius - 4.r,
            ),
            side: BorderSide(
              color: AppColors.neutralColor300,
              width: 1.w,
            ),
          ),
          color: Colors.white,
        ),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius - 4.r,
        ),
        icon: Icon(Icons.more_vert, color: AppColors.neutralColor600),
        itemBuilder: (BuildContext context) {
          return menuItems.map((item) {
            final String title = item['title'] as String;
            final IconData icon = item['icon'] as IconData;

            return PopupMenuItem<String>(
              value: title,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: AppColors.secondaryColor500,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    title,
                    style: Styles.captionEmphasis.copyWith(
                      color: AppColors.secondaryColor500,
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}