import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/features/banners/business_logic/banners_cubit.dart';
import 'package:nourex/features/banners/data/models/banners_data_model.dart';
import 'package:nourex/features/home/business_logic/home_cubit.dart';

class CustomSpecificBannerWidget extends StatelessWidget {
  const CustomSpecificBannerWidget({
    super.key,
    this.banners,
    this.banners2,
    this.isFetched = false,
  });

  final List<BannerModel>? banners;
  final List<String>? banners2;
  final bool? isFetched;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: isFetched == true
          ? banners!.length < 3
              ? banners!.length
              : 3
          : banners2!.length,
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
          context.read<BannersCubit>().changeIndexBanner(index);
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: isFetched == true
              ? () {
                  final banner = banners![index];

                  context.pushNamed(
                    Routes.productDetailsScreen,
                    arguments: banner.product?.id,
                  );
                }
              : null,
          child: CacheNetworkImagesWidget(
            image: isFetched == true
                ? banners![index].image ?? ''
                : banners2![index],
            boxFit: BoxFit.fill,
            borderRadius: AppConstants.borderRadius + 4.r,
          ),
        );
      },
    );
  }
}
