import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/features/banners/presentation/widgets/banner_widget.dart';

class AllBannersScreen extends StatelessWidget {
  const AllBannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> banners = [
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
      'assets/pngs/banner1.png',
      'assets/pngs/banner2.png',
      'assets/pngs/banner3.png',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'عروض خاصة',
          isSubScreen: true,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CacheNetworkImagesWidget(
                  image: banners[index],
                  boxFit: BoxFit.fill,
                  borderRadius: AppConstants.borderRadius + 4.r,
                );
              },
              separatorBuilder: (context, index) {
                return 12.verticalSpace;
              },
              itemCount: banners.length,
            ),
          ],
        ),
      ),
    );
  }
}
