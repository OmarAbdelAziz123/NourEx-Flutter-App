import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/features/products/presentation/widgets/custom_price_after_and_before_widget.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/cache_network_image/cache_network_image_widget.dart';

class CustomProductCardItemWidget extends StatelessWidget {
  const CustomProductCardItemWidget({
    super.key,
    required this.product,
    this.isInHome = true,
  });

  final ProductModel product;
  final bool isInHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: AppColors.neutralColor100,
        border: Border.all(
          color: AppColors.neutralColor300,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.borderRadius + 4.sp,
        ),
      ),
      child: Row(
        children: [
          CacheNetworkImagesWidget(
            image: product.mainImageURL ?? '',
            borderRadius: 3.r,
            boxFit: BoxFit.fill,
            width: 110.w,
            height: 100.h,
          ),
          12.horizontalSpace,
          isInHome == true
              ? Column(
                  spacing: 4.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: Styles.highlightEmphasis,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    Text(
                      product.id.toString() ?? '',
                      style: Styles.contentRegular.copyWith(
                        color: AppColors.neutralColor400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                    Row(
                      spacing: 4.w,
                      children: [
                        Text(
                          '2.5',
                          // product.productRate,
                          style: Styles.contentEmphasis.copyWith(
                            color: AppColors.yellowColor100,
                          ),
                        ),
                        ...List.generate(
                          double.tryParse('2.5')?.round() ?? 0,
                          // double.tryParse(product.productRate)?.round() ?? 0,
                          (index) => SvgPicture.asset(
                            'assets/svgs/stars.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        // SvgPicture.asset('assets/svgs/stars.svg'),
                        SvgPicture.asset('assets/svgs/small_circle.svg'),
                        Text(
                          '30 ${'order'.tr()}',
                          // '${product.countOfNumber} ${'order'.tr()}',
                          style: Styles.contentRegular.copyWith(
                            color: AppColors.neutralColor400,
                          ),
                        )
                      ],
                    ),

                    // CustomPriceAfterAndBeforeWidget(
                    //   priceBefore: '${product.price} ${'currency'.tr()}',
                    //   priceAfter: '${product.finalPrice} ${'currency'.tr()} ',
                    // ),
                  ],
                )
              : Expanded(
                  child: Column(
                    spacing: 4.h,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        style: Styles.highlightEmphasis,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      Text(
                        product.id.toString() ?? '',
                        style: Styles.contentRegular.copyWith(
                          color: AppColors.neutralColor400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      Row(
                        spacing: 4.w,
                        children: [
                          Text(
                            '2.5',
                            // product.productRate,
                            style: Styles.contentEmphasis.copyWith(
                              color: AppColors.yellowColor100,
                            ),
                          ),
                          ...List.generate(
                            double.tryParse('2.5')?.round() ?? 0,
                            // double.tryParse(product.productRate)?.round() ?? 0,
                            (index) => SvgPicture.asset(
                              'assets/svgs/stars.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          // SvgPicture.asset('assets/svgs/stars.svg'),
                          SvgPicture.asset('assets/svgs/small_circle.svg'),
                          Text(
                            '30 ${'order'.tr()}',
                            // '${product.countOfNumber} ${'order'.tr()}',
                            style: Styles.contentRegular.copyWith(
                              color: AppColors.neutralColor400,
                            ),
                          )
                        ],
                      ),

                      // CustomPriceAfterAndBeforeWidget(
                      //   priceBefore: '${product.price} ${'currency'.tr()}',
                      //   priceAfter: '${product.finalPrice} ${'currency'.tr()} ',
                      // ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
