import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class CustomBannerListSkeletonizerWidget extends StatelessWidget {
  const CustomBannerListSkeletonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          ShowMoreRowWidget(title: 'specialOffers'.tr(), onTapShowMore: () {}),
          12.verticalSpace,

          CarouselSlider.builder(
            itemCount: banners.length,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              padEnds: true,
              aspectRatio: 16.h / 8.h,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                // context.read<HomeCubit>().changeIndex(index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              final banner = banners[index];
              return CacheNetworkImagesWidget(
                image: banner,
                boxFit: BoxFit.fill,
                // haveBorder: true,
                borderRadius: AppConstants.borderRadius + 4.r,
              );
            },
          ),
          12.verticalSpace,
        ],
      ),
    );
  }
}