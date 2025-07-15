import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/components/products/custom_product_card_item_widget.dart';
import 'package:nourex/components/products/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';
import 'package:nourex/core/widgets/row/show_more_row_widget.dart';
import 'package:nourex/core/widgets/text/custom_text_rich_widget.dart';

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
    final products = [
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '3',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
      ProductDataModel(
        productName: 'تيشرت بولو',
        productImage: 'assets/pngs/shirt.png',
        productRate: '5',
        countOfNumber: '200',
        productPriceBefore: '2000',
        productPriceAfter: '1500',
      ),
    ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            18.verticalSpace,

            Padding(
              padding: EdgeInsets.only(left: 18.w, right: 18.w),
              child: Column(
                children: [
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
                    // margin: EdgeInsets.only(left: 18.w, right: 18.w),
                    padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
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
                                  color: image == selectedImage
                                      ? AppColors.primaryColor700
                                      : Colors.transparent,
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
                  18.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'تيشيرت',
                            style: Styles.captionRegular.copyWith(
                              color: AppColors.neutralColor600,
                            ),
                          ),
                          8.horizontalSpace,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor500,
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderRadius + 18.r,
                              ),
                            ),
                            child: Text(
                              '12 متبقي',
                              style: Styles.captionEmphasis.copyWith(
                                color: AppColors.neutralColor100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/svgs/share_icon.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                  4.verticalSpace,

                  Text(
                    'تيشرت بولو',
                    style: Styles.featureSemiBold,
                  ),
                  4.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 12.w,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.neutralColor300,
                            radius: 13.r,
                          ),
                          Text(
                            'عمر عبدالعزيز',
                            style: Styles.contentBold.copyWith(
                              color: AppColors.secondaryColor500,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svgs/water_mark_icon.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ],
                      ),
                      Text(
                        '6933399 ل.س',
                        style: Styles.heading4,
                      )
                    ],
                  ),
                  18.verticalSpace,

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralColor100,
                      borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                      border: Border.all(
                        color: AppColors.neutralColor300,
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomVariantColumnWidget(
                          isColored: true,
                          variantName: 'الاوان',
                        ),
                        CustomVariantColumnWidget(
                          variantName: 'الحجم',
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,

                  /// Description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralColor100,
                      borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                      border: Border.all(
                        color: AppColors.neutralColor300,
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الوصف',
                          style: Styles.highlightEmphasis,
                        ),
                        Text(
                          'دلّلي بشرتك برذاذ GlowMist المنعش!  تركيبة خفيفة وغنية بحمض الهيالورونيك وفيتامين E تمنحك ترطيبًا فوريًا ولمعانًا طبيعيًا يدوم طوال اليوم.  مثالي للاستخدام قبل المكياج أو أثناء اليوم لتجديد الحيوية.',
                          style: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  18.verticalSpace,

                  /// Product Number
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutralColor100,
                      borderRadius:
                      BorderRadius.circular(AppConstants.borderRadius),
                      border: Border.all(
                        color: AppColors.neutralColor300,
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomRichText(
                              text1: 'رقم المنتج: ',
                              textStyle1: Styles.highlightEmphasis,
                              text2: '0102102',
                              textStyle2: Styles.contentRegular.copyWith(
                                  color: AppColors.neutralColor800
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   'الوصف',
                        //   style: Styles.highlightEmphasis,
                        // ),
                      ],
                    ),
                  ),
                  18.verticalSpace,
                ],
              ),
            ),

            /// Similar Products
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ShowMoreRowWidget(
                title: 'منتجات المشابههً',
                onTapShowMore: () {},
              ),
            ),
            12.verticalSpace,

            SizedBox(
              height: 124.h,
              child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      right: index == 0 ? 18.w : 0,
                      left: index == products.length - 1 ? 18.w : 12.w,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.pushNamed(Routes.productDetailsScreen);
                      },
                      child: CustomProductCardItemWidget(
                        product: products[index],
                      ),
                    ),
                    // child: CustomProductCardItemSkeletonizerWidget(),
                  );
                },
              ),
            ),
            18.verticalSpace,

          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'أضف الي السلة',
        onPressed: () {},
      ),
    );
  }
}

class CustomVariantColumnWidget extends StatelessWidget {
  const CustomVariantColumnWidget({
    super.key,
    required this.variantName,
    this.isColored = false,
  });

  final String variantName;
  final bool? isColored;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          variantName,
          style: Styles.contentEmphasis,
        ),
        4.verticalSpace,
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                    color: isColored == true
                        ? AppColors.primaryColor700
                        : AppColors.neutralColor100,
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderRadius - 4.r,
                    ),
                    border: Border.all(
                      color: AppColors.neutralColor300,
                      width: 1.w,
                    )),
                child: isColored == true
                    ? Center(
                  child: Text(
                    'M',
                    style: Styles.contentRegular.copyWith(
                      color: Colors.transparent,
                    ),
                  ),
                )
                    : Center(
                        child: Text(
                          'S',
                          style: Styles.contentRegular,
                        ),
                      ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
