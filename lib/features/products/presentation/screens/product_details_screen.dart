import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String selectedImage;
  bool isButtonClicked = false;
  final imagesList = [
    'assets/svgs/shirt2.png',
    'assets/pngs/shirt3.png',
    'assets/pngs/shirt4.png',
    'assets/pngs/shirt5.png',
    'assets/pngs/shirt6.png',
  ];

  @override
  void initState() {
    super.initState();
    selectedImage = imagesList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: 'تيشرت بولو',
          isSubScreen: true,
          haveOnlyNotification: false,
          onTapBack: () {
            context.pop();
          },
          onTapSearch: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
          child: Column(
            children: [
              18.verticalSpace,

              /// Image Main
              // CacheNetworkImagesWidget(
              //   image: 'assets/svgs/shirt2.png',
              //   width: double.infinity,
              //   height: 249.h,
              //   boxFit: BoxFit.fill,
              //   borderRadius: 10.r,
              // ),
              /// Main Image
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: CacheNetworkImagesWidget(
                  key: ValueKey(selectedImage),
                  image: selectedImage,
                  width: double.infinity,
                  height: 249.h,
                  boxFit: BoxFit.fill,
                  borderRadius: 10.r,
                ),
              ),
              12.verticalSpace,

              /// Images Row
              Container(
                width: double.infinity,
                height: 60.h,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: AppColors.neutralColor300,
                    width: 1.w,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius + 4.r),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(imagesList.length, (index) {
                      final image = imagesList[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = image;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.all(2.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: image == selectedImage ? AppColors.primaryColor700 : Colors.transparent,
                              width: 1.5.w,
                            ),
                            borderRadius: BorderRadius.circular(
                              AppConstants.borderRadius - 2.r,
                            ),
                          ),
                          child: CacheNetworkImagesWidget(
                            image: imagesList[index],
                            width: 62.w,
                            height: 41.h,
                            boxFit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'أضف الي السلة',
        onPressed: () {},
      ),
    );
  }
}
