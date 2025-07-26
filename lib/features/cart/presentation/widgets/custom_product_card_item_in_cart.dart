import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/features/products/presentation/widgets/custom_price_after_and_before_widget.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/hex_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class CustomProductCardItemInCartWidget extends StatelessWidget {
  const CustomProductCardItemInCartWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.toString() == 'ar_EG';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutralColor100,
        border: Border.all(color: AppColors.neutralColor300, width: 1.w),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius + 4.sp),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: isArabic == false ? BorderRadius.only(
              topLeft: Radius.circular(AppConstants.borderRadius + 4.r),
              bottomLeft: Radius.circular(AppConstants.borderRadius + 4.r),
            ) : BorderRadius.only(
              topRight: Radius.circular(AppConstants.borderRadius + 4.r),
              bottomRight: Radius.circular(AppConstants.borderRadius + 4.r),
            ),
            child: Stack(
              children: [
                /// Product Image
                CacheNetworkImagesWidget(
                  image: product.mainImageURL ?? '',
                  borderRadius: 12.r,
                  haveBorder: false,
                  boxFit: BoxFit.cover,
                  width: 120.w,
                  height: 120.h,
                ),

                /// Product Category
                Positioned(
                  top: 8.h,
                  right: isArabic == false ? null : 8.w,
                  left: isArabic == true ? null : 8.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor500,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      child: Text(
                        'ملابس رجالية',
                        style: Styles.footnoteEmphasis.copyWith(
                          color: AppColors.neutralColor100,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(0.sp),
              child: Column(
                spacing: 4.h,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name ?? '', style: Styles.highlightEmphasis),
                  Row(
                    children: [
                      CustomPriceAfterAndBeforeWidget(
                        priceBefore: '${product.price}${'currency'}',
                        priceAfter: '${product.discount} ${'currency'}  ',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomContainerInCartItem(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(AppConstants.borderRadius),
                              bottomRight: Radius.circular(AppConstants.borderRadius),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Icon(Icons.add, color: AppColors.neutralColor1000),
                            ),
                          ),
                          CustomContainerInCartItem(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(0),
                            ),
                            child: Text(
                              '1',
                              // product.countOfNumber,
                              style: Styles.contentRegular,
                            ),
                          ),
                          CustomContainerInCartItem(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppConstants.borderRadius),
                              bottomLeft: Radius.circular(AppConstants.borderRadius),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Icon(Icons.remove, color: AppColors.neutralColor1000),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            'assets/svgs/remove.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainerInCartItem extends StatelessWidget {
  const CustomContainerInCartItem({
    super.key,
    required this.child,
    required this.borderRadius,
  });

  final Widget child;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: hexToColor('#EEEEEE'), width: .5.w),
      ),
      child: child,
    );
  }
}
