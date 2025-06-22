import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16.h / 8.h,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration:
            const Duration(milliseconds: 800),
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
              haveBorder: true,
              borderRadius: 12.r,
            );
          },
        ),
        SizedBox(height: 12.h),
        // AnimatedSmoothIndicator(
        //   activeIndex: context.read<HomeCubit>().currentBannerIndex,
        //   count: banners.length,
        //   effect: WormEffect(
        //     dotHeight: 6.h,
        //     dotWidth: 6.w,
        //     activeDotColor: AppColors.primaryColor900,
        //     dotColor: AppColors.neutralColor200,
        //   ),
        // ),
      ],
    );
  }
}
