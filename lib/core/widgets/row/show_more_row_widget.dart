import 'package:flutter/cupertino.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/show_more/show_more_widget.dart';

class ShowMoreRowWidget extends StatelessWidget {
  const ShowMoreRowWidget({super.key, required this.title, required this.onTapShowMore});

  final String title;
  final VoidCallback onTapShowMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Styles.featureBold.copyWith(
            color: AppColors.neutralColor1000,
          ),
        ),
        ShowMoreWidget(onTapShowMore: onTapShowMore),
      ],
    );
  }
}
