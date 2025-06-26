import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/custom_specific_banner_widget.dart';

class CustomBannerListWidget extends StatelessWidget {
  const CustomBannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Column(
      children: [
        ShowMoreRowWidget(
          title: 'عروض خاصة',
          onTapShowMore: () {
            context.pushNamed(Routes.allBannersScreen);
          },
        ),
        12.verticalSpace,

        CustomSpecificBannerWidget(banners: banners),
        12.verticalSpace,
      ],
    );
  }
}