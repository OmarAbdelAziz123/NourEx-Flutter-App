import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';

class ShowMoreWidget extends StatelessWidget {
  const ShowMoreWidget({
    super.key,
    required this.onTapShowMore,
    this.showMore = true,
    this.text,
  });

  final VoidCallback onTapShowMore;
  final bool showMore;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapShowMore,
      child: Text(
        showMore == true ? "showMore".tr() : text ?? '',
        style: Styles.contentEmphasis.copyWith(
          color: AppColors.primaryColor700,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryColor700,
        ),
      ),
    );
  }
}
