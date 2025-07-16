import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/show_more/show_more_widget.dart';

class ShowMoreRowWidget extends StatelessWidget {
  const ShowMoreRowWidget({
    super.key,
    this.title,
    required this.onTapShowMore,
    this.isRate = false, this.avgRate, this.totalOfRate,
  });

  final bool? isRate;
  final String? title;
  final String? avgRate;
  final String? totalOfRate;
  final VoidCallback onTapShowMore;

  @override
  Widget build(BuildContext context) {
    return isRate == true
        ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8.w,
          children: [
            Text(
              'التقيمات',
              style: Styles.featureBold.copyWith(
                color: AppColors.neutralColor1000,
              ),
            ),
            SvgPicture.asset(
              'assets/svgs/rate_icon.svg',
              color: AppColors.yellowColor100,
              height: 16.h,
              width: 16.w,
            ),
            Text(
              '$avgRate ($totalOfRate) تقييمًا',
              style: Styles.captionBold.copyWith(
                color: AppColors.neutralColor600,
              ),
            ),
          ],
        ),
        ShowMoreWidget(onTapShowMore: onTapShowMore),
      ],
    )
        : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title!,
              style: Styles.featureBold.copyWith(
                color: AppColors.neutralColor1000,
              ),
            ),
            ShowMoreWidget(onTapShowMore: onTapShowMore),
          ],
        );
  }
}
