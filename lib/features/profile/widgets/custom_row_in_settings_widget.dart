import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/features/profile/data/models/settings/settings_data_model.dart';
import 'package:nourex/features/profile/widgets/custom_arrow_in_containers_widget.dart';

class CustomRowInSettingsWidget extends StatelessWidget {
  const CustomRowInSettingsWidget({
    super.key,
    required this.isLang,
    required this.settingsDataModel,
  });

  final SettingsDataModel settingsDataModel;
  final bool isLang;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: settingsDataModel.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 8.h,
              children: [
                SvgPicture.asset(
                  settingsDataModel.iconPath,
                  fit: BoxFit.scaleDown,
                ),
                Text(
                  settingsDataModel.title,
                  style: Styles.highlightEmphasis,
                ),
              ],
            ),
            Row(
              spacing: 8.w,
              children: [
                isLang
                    ? Text(
                  context.locale.toString() == 'ar_EG'
                      ? "العربية"
                      : "English",
                  style: Styles.highlightEmphasis.copyWith(
                    color: AppColors.neutralColor600,
                  ),
                )
                    : SizedBox.shrink(),
                CustomArrowInContainersWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
