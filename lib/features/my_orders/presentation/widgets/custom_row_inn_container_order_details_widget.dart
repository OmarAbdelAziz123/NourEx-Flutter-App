import 'package:flutter/material.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';

class CustomRowInContainerOrderDetailsWidget extends StatelessWidget {
  const CustomRowInContainerOrderDetailsWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomRichText(
          text1: title,
          text2: value,
          textStyle1: Styles.contentEmphasis.copyWith(
            color: AppColors.neutralColor600,
          ),
          textStyle2: Styles.captionRegular,
        ),
      ],
    );
  }
}