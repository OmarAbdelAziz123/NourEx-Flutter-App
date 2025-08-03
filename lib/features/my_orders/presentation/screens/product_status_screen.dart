import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nourex/core/extensions/navigation_extension.dart';
import 'package:nourex/core/themes/app_colors.dart';
import 'package:nourex/core/themes/text_colors.dart';
import 'package:nourex/core/widgets/appbar/main_app_bar_2_widget.dart';
import 'package:nourex/features/my_orders/data/models/my_orders_data_model.dart';
import 'package:nourex/features/my_orders/presentation/widgets/custom_container_in_order_details_to_connect_the_three_status_widget.dart';
import 'package:nourex/features/my_orders/presentation/widgets/time_line_stage_widget.dart';

class ProductStatusScreen extends StatelessWidget {
  const ProductStatusScreen({super.key, required this.myOrderProduct});

  final MyOrderProduct myOrderProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.h),
        child: MainAppBar2Widget(
          title: '${'productNumber'.tr()} : ${myOrderProduct.itemSeq}',
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
          padding: EdgeInsets.only(top: 18.h, left: 18.w, right: 18.w),
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
                            SvgPicture.asset(
                              myOrderProduct.status == 'Delivered'
                                  ? 'assets/svgs/pending_icon3.svg'
                                  : myOrderProduct.status != 'Pending'
                                      ? 'assets/svgs/pending_icon1.svg'
                                      : 'assets/svgs/pending_icon2.svg',
                            ),
                            CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
                              color: myOrderProduct.status == 'Pending'
                                  ? AppColors.neutralColor300
                                  : null,
                            ),
                          ],
                        ),
                        TimelineStageWidget(
                          stage: 'firstStep'.tr(),
                          status: myOrderProduct.status == 'Pending'
                              ? 'pending'.tr()
                              : 'completed'.tr(),
                          description: 'firstStepDescription'.tr(),
                          buttonText: myOrderProduct.status == 'Pending'
                              ? " جاري العمل عليه"
                              : 'completed'.tr(),
                          isCompleted: myOrderProduct.status != 'Pending',
                          inProgressColor: myOrderProduct.status == 'Pending',
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
                              myOrderProduct.status == 'Shipped'
                                  ? 'assets/svgs/delevering_icon3.svg'
                                  : myOrderProduct.status == 'Delivered'
                                      ? 'assets/svgs/delevering_icon1.svg'
                                      : 'assets/svgs/delevering_icon2.svg',
                            ),
                            CustomContainerInOrderDetailsToConnectTheThreeStatusWidget(
                              color: myOrderProduct.status == 'Shipped'
                                  ? AppColors.neutralColor300
                                  : null,
                            ),
                          ],
                        ),
                        TimelineStageWidget(
                          stage: 'secondStep'.tr(),
                          // status: 'secondStepDescription'.tr(),
                          status: myOrderProduct.status == 'Shipped'
                              ? 'shipped'.tr()
                              : myOrderProduct.status == 'Delivered'
                                  ? 'completed'.tr()
                                  : myOrderProduct.status == 'Pending'
                                      ? 'pending'.tr()
                                      : 'cancelled'.tr(),
                          description: 'thirdStep'.tr(),
                          // buttonText: 'fourthStep'.tr(),
                          buttonText: myOrderProduct.status == 'Shipped'
                              ? " جاري العمل عليه"
                              : 'completed'.tr(),
                          isCompleted: myOrderProduct.status == 'Delivered',
                          inProgressColor: myOrderProduct.status == 'Shipped',
                        ),
                      ],
                    ),
                  ),

                  /// Third Stage
                  Row(
                    spacing: 16.w,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        myOrderProduct.status == 'Returned'
                            ? 'assets/svgs/returened_icon1.svg'
                            : myOrderProduct.status == 'Pending' ||
                                    myOrderProduct.status == 'Shipped'
                                ? 'assets/svgs/returened_icon2.svg'
                                : myOrderProduct.status == 'Delivered'
                                    ? 'assets/svgs/delevered_icon1.svg'
                                    : 'assets/svgs/delevered_icon2.svg',
                      ),
                      TimelineStageWidget(
                        stage: 'thirdStepDescription'.tr(),
                        status: myOrderProduct.status == 'Delivered'
                            ? 'delivered'.tr()
                            : myOrderProduct.status == 'Pending' ||
                                    myOrderProduct.status == 'Shipped'
                                ? 'pending'.tr()
                                : 'returned'.tr(),
                        description: myOrderProduct.status == 'Returned'
                            ? 'doneReturned'.tr()
                            : 'fourthStepDescription'.tr(),
                        // buttonText: 'fourthStep'.tr(),
                        buttonText: myOrderProduct.status == 'Returned'
                            ? 'returned'.tr()
                            : myOrderProduct.status == 'Delivered'
                                ? 'completed'.tr()
                                : 'pending'.tr(),
                        isCompleted: myOrderProduct.status == 'Delivered',
                        // Last step is never "completed"
                        inProgressColor: myOrderProduct.status == 'Delivered',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
