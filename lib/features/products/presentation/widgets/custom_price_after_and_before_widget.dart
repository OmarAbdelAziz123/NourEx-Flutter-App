import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';

class CustomPriceAfterAndBeforeWidget extends StatelessWidget {
  const CustomPriceAfterAndBeforeWidget({
    super.key,
    required this.priceBefore,
    required this.priceAfter,
  });

  final String priceBefore;
  final String priceAfter;

  @override
  Widget build(BuildContext context) {
    return CustomRichText(
      text1: priceAfter,
      text2: priceBefore,
      textStyle1: Styles.highlightEmphasis,
      textStyle2: Styles.captionSemiBold.copyWith(
        color: AppColors.redColor100,
        decoration: TextDecoration.lineThrough,
        decorationColor: AppColors.redColor100,
        decorationThickness: 2.w,
      ),
    );
  }
}
