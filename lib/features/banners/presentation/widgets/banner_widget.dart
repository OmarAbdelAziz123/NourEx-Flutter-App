import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/custom_banner_list_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBannerListWidget(),
      ],
    );
  }
}


