import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';

class CustomSpecificBannerWidget extends StatelessWidget {
  const CustomSpecificBannerWidget({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
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
          context.read<HomeCubit>().changeIndexBanner(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final banner = banners[index];
        return CacheNetworkImagesWidget(
          image: banner,
          boxFit: BoxFit.fill,
          borderRadius: AppConstants.borderRadius + 4.r,
        );
      },
    );
  }
}