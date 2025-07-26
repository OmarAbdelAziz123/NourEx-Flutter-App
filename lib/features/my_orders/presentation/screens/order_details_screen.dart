import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/features/products/data/models/product_data_model.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/routing/routes_name.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/utils/app_constants.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/core/widgets/bottom_nav_bar/custom_bottom_nav_bar_make_button_only.dart';
import 'package:nourex/core/widgets/divider/custom_divider_in_bottom_sheet.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_container_in_order_details_to_connect_the_three_status_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_row_inn_container_order_details_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/time_line_stage_widget.dart';
import 'package:nourex/features/products/presentation/widgets/custom_product_card_item_widget.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final products = [
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '3',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    //   ProductDataModel(
    //     productName: 'تيشرت بولو',
    //     productImage: 'assets/pngs/shirt.png',
    //     productRate: '5',
    //     countOfNumber: '200',
    //     productPriceBefore: '2000',
    //     productPriceAfter: '1500',
    //   ),
    // ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: '${'orderNumber'.tr()} : 21343434341',
          isSubScreen: true,
          haveOnlyNotification: true,
          onTapBack: () {
            context.pop();
          },
          onTapNotification: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              18.verticalSpace,
              Text('executionSteps'.tr(), style: Styles.highlightEmphasis),
              12.verticalSpace,

              /// Status Timeline with IntrinsicHeight for better alignment
              Column(
                children: [
                  /// First Stage
                  IntrinsicHeight(
                    child: Row(
                      spacing: 16.w,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset('assets/svgs/pending_icon1.svg'),
                            CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(),
                          ],
                        ),
                        TimelineStageWidget(
                          stage: 'firstStep'.tr(),
                          status: 'completed'.tr(),
                          description: 'firstStepDescription'.tr(),
                          buttonText: 'completed'.tr(),
                          isCompleted: true,
                        ),
                      ],
                    ),
                  ),

                  /// Second Stage
                  IntrinsicHeight(
                    child: Row(
                      spacing: 16.w,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/delevering_icon1.svg',
                            ),
                            CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(),
                          ],
                        ),
                        TimelineStageWidget(
                          stage: 'secondStep'.tr(),
                          status: 'secondStepDescription'.tr(),
                          description: 'thirdStep'.tr(),
                          buttonText: 'fourthStep'.tr(),
                          isCompleted: true,
                        ),
                      ],
                    ),
                  ),

                  /// Third Stage
                  Row(
                    spacing: 16.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svgs/delevered_icon1.svg'),
                      TimelineStageWidget(
                        stage: 'thirdStepDescription'.tr(),
                        status: 'delivered'.tr(),
                        description:
                            'fourthStepDescription'.tr(),
                        buttonText: 'fourthStep'.tr(),
                        isCompleted: true,
                      ),
                    ],
                  ),
                ],
              ),

              /// Order Details
              24.verticalSpace,
              Text('productInfo'.tr(), style: Styles.highlightEmphasis),
              12.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.neutralColor600,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius + 4.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neutralColor600.withAlpha(1),
                      blurRadius: 60.r,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  spacing: 12.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'name'.tr(),
                        value: 'عمر عبدالعزيز',
                      ),
                    ),
                    CustomDividerInBottomSheet(),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'phone'.tr(),
                        value: '01023359621',
                      ),
                    ),
                    CustomDividerInBottomSheet(),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'date'.tr(),
                        value: '19 ديسمبر 2024',
                      ),
                    ),
                    CustomDividerInBottomSheet(),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'address2'.tr(),
                        value: 'العنوان : العنوان : ',
                      ),
                    ),
                    CustomDividerInBottomSheet(),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'notes2'.tr(),
                        value: 'نص نص نص',
                      ),
                    ),
                    CustomDividerInBottomSheet(),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 8.h),
                      child: CustomRowInContainerOrderDetailsWidget(
                        title: 'orderNumber2'.tr(),
                        value: '21343434341',
                      ),
                    ),
                  ],
                ),
              ),
              18.verticalSpace,

              /// Order Products
              Text('products'.tr(), style: Styles.featureBold),
              12.verticalSpace,
              // Container(
              //   child: ListView.separated(
              //     shrinkWrap: true,
              //     padding: EdgeInsets.zero,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: products.length,
              //     itemBuilder: (context, index) {
              //       return CustomProductCardItemWidget(
              //         product: products[index],
              //       );
              //     },
              //     separatorBuilder: (context, index) => 12.verticalSpace,
              //   ),
              // ),

              24.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarMakeButtonOnly(
        buttonTitle: 'returnOrder'.tr(),
        onPressed: () {
          context.pushNamed(Routes.cancelOrderScreen);
        },
      ),
    );
  }
}