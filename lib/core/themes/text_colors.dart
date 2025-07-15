import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';

abstract class Styles {
  static TextStyle getLocalizedTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double? letterSpacing,
  }) {
    final context = AppConstants.navigatorKey.currentContext!;
    final isArabic = context.locale.toString() == 'ar_EG';

    return TextStyle(
      fontFamily: isArabic ? GoogleFonts.cairo().fontFamily : GoogleFonts.poppins().fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle get  display1 => getLocalizedTextStyle(
    fontSize: 44,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get display2 => getLocalizedTextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,

  );
  static TextStyle get display3 => getLocalizedTextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get heading1 => getLocalizedTextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get heading2 => getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get heading3 => getLocalizedTextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get heading4 => getLocalizedTextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );

  static TextStyle get featureBold => getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get featureSemiBold => getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get featureEmphasis => getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get featureStandard => getLocalizedTextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get highlightBold => getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get highlightSemiBold => getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get highlightEmphasis => getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get highlightStandard => getLocalizedTextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralColor1000,
  );

  static TextStyle get contentBold => getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle get contentSemiBold => getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralColor1000,
  );
  static TextStyle contentEmphasis = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.neutralColor1000,
  );
  static TextStyle contentRegular = getLocalizedTextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralColor1000,
  );

  static TextStyle captionBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle captionSemiBold = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.neutralColor1000,
  );
  static TextStyle captionEmphasis = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.neutralColor1000,
  );
  static TextStyle captionRegular = getLocalizedTextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralColor1000,
  );

  static TextStyle footnoteBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle footnoteSemiBold = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColors.neutralColor1000,
  );
  static TextStyle footnoteEmphasis = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.neutralColor1000,
  );
  static TextStyle footnoteRegular = getLocalizedTextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: AppColors.neutralColor1000,
  );
}
